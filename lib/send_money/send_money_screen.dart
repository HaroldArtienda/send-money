import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:send_money/common_ui/sm_bottom_sheet.dart';
import 'package:send_money/common_ui/sm_common_button.dart';
import 'package:send_money/common_ui/sm_common_text_field.dart';
import 'package:send_money/common_ui/sm_logout_fab.dart';
import 'package:send_money/send_money/bloc/send_money_bloc.dart';
import 'package:send_money/send_money/bloc/send_money_event.dart';
import 'package:send_money/send_money/bloc/send_money_state.dart';
import 'package:send_money/utils/constants.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showResultBottomSheet({
    required bool isSuccess,
    required String amount,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SMBottomSheet(isSuccess: isSuccess, amount: amount);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sendMoneyBloc = context.read<SendMoneyBloc>();

    return Scaffold(
      floatingActionButton: const SMLogoutFAB(),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SMCommonTextField(
                controller: _amountController,
                hintText: 'Enter amount',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                validator: validator,
                onChanged: (val) => setState(() {}),
              ),
              const SizedBox(height: 24.0),
              BlocConsumer<SendMoneyBloc, SendMoneyState>(
                  listener: (context, state) {
                state.status == SendMoneyStatus.done
                    ? _showResultBottomSheet(
                        isSuccess: state.success,
                        amount: _amountController.text)
                    : null;
              }, builder: (context, state) {
                return state.status == SendMoneyStatus.loading
                    ? CircularProgressIndicator()
                    : SMCommonButton(
                        title: 'Send',
                        height: 50,
                        width: double.infinity,
                        isFilled: true,
                        isEnabled: _amountController.text.trim().isNotEmpty,
                        onTap: () => _handleSend(sendMoneyBloc),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSend(SendMoneyBloc bloc) {
    if (_formKey.currentState?.validate() ?? false) {
      final parsedAmount = double.tryParse(_amountController.text) ?? 0;
      bloc.add(SendMoney(parsedAmount));
    }
  }

  String? validator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Enter a valid amount';
    }
    return null;
  }
}
