import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/dto/transaction.dart';
import 'package:send_money/home/interactor/home_interactor.dart';
import 'package:send_money/home/interactor/home_interactor_impl.dart';

import '../mocks/home_mocks.mocks.dart';

void main() {
  late MockTransactionService mockService;
  late HomeInteractor interactor;

  setUp(() {
    mockService = MockTransactionService();
    interactor = HomeInteractorImpl(mockService);
  });

  group('HomeInteractorImpl', () {
    test('getWallet returns the correct sum of transaction amounts', () async {
      final transactions = [
        Transaction(
          id: '1',
          transactionId: 'TXN001',
          transactionAmount: 150.75,
          date: DateTime.now(),
          transactionType: 'credit',
        ),
        Transaction(
          id: '2',
          transactionId: 'TXN002',
          transactionAmount: 49.25,
          date: DateTime.now(),
          transactionType: 'credit',
        ),
      ];

      when(mockService.getTransactions()).thenAnswer((_) async => transactions);

      final result = await interactor.getWallet();

      expect(result, 200.0);
      verify(mockService.getTransactions()).called(1);
    });

    test('getWallet returns 0 when transaction list is empty', () async {
      when(mockService.getTransactions()).thenAnswer((_) async => []);

      final result = await interactor.getWallet();

      expect(result, 0.0);
      verify(mockService.getTransactions()).called(1);
    });
  });
}
