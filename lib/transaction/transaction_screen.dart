import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:send_money/common_ui/sm_logout_fab.dart';
import 'package:send_money/transaction/bloc/transaction_bloc.dart';
import 'package:send_money/transaction/bloc/transaction_state.dart';
import 'package:send_money/utils/constants.dart';
import 'package:send_money/utils/extensions.dart';
import 'package:send_money/utils/sm_text_style.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat.yMMMd().add_jm();

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const SMLogoutFAB(),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          final transactions = state.transactions;

          return state.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: transactions.length + 1,
                  separatorBuilder: (_, index) {
                    if (index >= transactions.length - 1)
                      return const SizedBox.shrink();
                    return const Divider(height: 1, thickness: 1);
                  },
                  itemBuilder: (context, index) {
                    if (index == transactions.length) {
                      return SizedBox(height: context.height * 0.1);
                    }

                    final transaction = transactions[index];
                    final isDeposit = transaction.transactionType == 'deposit';
                    final formattedAmount =
                        "${isDeposit ? '+' : '-'}${formatMoney(transaction.transactionAmount)}";
                    final date = dateFormatter.format(transaction.date);

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Transaction ID: ${transaction.transactionId}',
                          style: SMTextStyle.transactionIdTitle(),
                        ),
                        subtitle: Text(
                          date,
                          style: SMTextStyle.transactionDateTitle(),
                        ),
                        trailing: Text(
                          formattedAmount,
                          style: SMTextStyle.transactionAmountTitle(isDeposit)
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
