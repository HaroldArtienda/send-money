import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:send_money/common_ui/sm_common_button.dart';
import 'package:send_money/common_ui/sm_common_text_field.dart';
import 'package:send_money/utils/constants.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSend() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = _amountController.text;

      // Simulated logic: success if amount < 5000
      final parsedAmount = double.tryParse(amount) ?? 0;
      final isSuccess = parsedAmount < 5000;

      _showResultBottomSheet(isSuccess: isSuccess, amount: amount);
    }
  }

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
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                isSuccess ? 'Success' : 'Failed',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                isSuccess
                    ? '₱$amount has been sent successfully!'
                    : 'Sending ₱$amount failed. Please try again.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              SMCommonButton(
                title: 'Done',
                height: 50,
                width: double.infinity,
                isFilled: true,
                onTap: () {
                  Navigator.of(context).pop();
                  context.replace(SMRoute.home.path);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Amount is required';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {}); // Refresh button state
                },
              ),
              const SizedBox(height: 24.0),
              SMCommonButton(
                title: 'Send',
                height: 50,
                width: double.infinity,
                isFilled: true,
                isEnabled: _amountController.text.trim().isNotEmpty,
                onTap: _handleSend,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
