import 'package:send_money/dto/transaction.dart';
import 'package:send_money/send_money/interactor/send_money_interactor.dart';
import 'package:send_money/service/transaction_service.dart';

class SendMoneyInteractorImpl implements SendMoneyInteractor {
  late final TransactionService _service;

  SendMoneyInteractorImpl(this._service);

  @override
  bool isValid(double amount) {
    return amount < 5000;
  }

  @override
  Future<Transaction?> sendMoney(double amount) async {
    final createTransaction = Transaction.createNew(amount);
    final jsonTransaction = createTransaction.toJson();

    try {
      return await _service.createTransaction(jsonTransaction);
    } catch (e) {
      throw (Exception);
    }
  }
}
