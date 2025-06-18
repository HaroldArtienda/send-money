import '../../dto/transaction.dart';

abstract class TransactionInteractor {
  Future<List<Transaction>> getTransactions();
}
