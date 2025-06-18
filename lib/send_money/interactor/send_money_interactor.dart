import 'package:send_money/dto/transaction.dart';

abstract class SendMoneyInteractor {

  bool isValid(double amount);
  Future<Transaction?> sendMoney(double amount);
}