import 'package:send_money/send_money/interactor/send_money_interactor.dart';

class SendMoneyInteractorImpl implements SendMoneyInteractor {
  @override
  Future<bool> isValid(double amount) async {
    await Future.delayed(Duration(milliseconds: 2000));
    return amount < 5000;
  }
}
