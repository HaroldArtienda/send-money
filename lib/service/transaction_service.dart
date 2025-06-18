import 'package:send_money/dto/transaction.dart';

abstract class TransactionService {
  Future<List<Transaction>> getTransactions();

  Future<Transaction?> createTransaction(Map<String, dynamic> json);
}
