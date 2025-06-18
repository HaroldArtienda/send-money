import 'package:mockito/annotations.dart';
import 'package:send_money/send_money/interactor/send_money_interactor.dart';
import 'package:send_money/service/transaction_service.dart';

@GenerateMocks([SendMoneyInteractor, TransactionService])
void main() {}
