abstract class SendMoneyEvent {}

class SendMoney extends SendMoneyEvent {
  final double amount;
  SendMoney(this.amount);
}
