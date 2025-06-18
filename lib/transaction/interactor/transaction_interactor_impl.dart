import 'package:send_money/service/transaction_service.dart';

import '../../dto/transaction.dart';
import 'transaction_interactor.dart';

class TransactionInteractorImpl implements TransactionInteractor {
  final TransactionService service;

  TransactionInteractorImpl(this.service);

  @override
  Future<List<Transaction>> getTransactions() async {
    final result = await service.getTransactions();
    final transactions = [...result]..sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }
}
