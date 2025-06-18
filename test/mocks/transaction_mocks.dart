import 'package:mockito/annotations.dart';
import 'package:send_money/service/transaction_service.dart';
import 'package:send_money/transaction/interactor/transaction_interactor.dart';

@GenerateMocks([TransactionInteractor, TransactionService])
void main() {}
