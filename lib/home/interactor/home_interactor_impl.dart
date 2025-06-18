import 'package:send_money/home/interactor/home_interactor.dart';
import 'package:send_money/service/transaction_service.dart';

class HomeInteractorImpl implements HomeInteractor {
  late final TransactionService service;

  HomeInteractorImpl(this.service);

  @override
  Future<double> getWallet() async {
    final result = await service.getTransactions();
    final totalAmount = result.fold<double>(
      0.0,
      (sum, transaction) => sum + transaction.transactionAmount,
    );
    return totalAmount ?? 0;
  }
}
