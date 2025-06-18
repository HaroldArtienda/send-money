import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/home/interactor/home_interactor.dart';

import 'package:send_money/login/interactor/login_interactor.dart';
import 'package:send_money/service/transaction_service.dart';

@GenerateMocks([HomeInteractor, TransactionService])
void main() {}
