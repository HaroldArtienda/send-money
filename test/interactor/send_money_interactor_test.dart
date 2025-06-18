import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/dto/transaction.dart';
import 'package:send_money/send_money/interactor/send_money_interactor_impl.dart';

import '../mocks/send_money_mocks.mocks.dart';

void main() {
  late SendMoneyInteractorImpl interactor;
  late MockTransactionService mockService;

  setUp(() {
    mockService = MockTransactionService();
    interactor = SendMoneyInteractorImpl(mockService);
  });

  group('isValid', () {
    test('returns true when amount is less than 5000', () {
      final result = interactor.isValid(4999.99);
      expect(result, isTrue);
    });

    test('returns false when amount is equal to or greater than 5000', () {
      expect(interactor.isValid(5000), isFalse);
      expect(interactor.isValid(10000), isFalse);
    });
  });

  group('sendMoney', () {
    test('returns transaction when service responds successfully', () async {
      // Arrange
      final fakeTransaction = Transaction.createNew(2000);
      final json = fakeTransaction.toJson();

      when(mockService.createTransaction(any))
          .thenAnswer((_) async => fakeTransaction);

      // Act
      final result = await interactor.sendMoney(2000);

      // Assert
      expect(result, isNotNull);
      expect(result?.transactionAmount, 2000);
      verify(mockService.createTransaction(any)).called(1);
    });

    test('returns null when service fails', () async {
      when(mockService.createTransaction(any)).thenAnswer((_) async => null);

      final result = await interactor.sendMoney(2000);

      expect(result, isNull);
      verify(mockService.createTransaction(any)).called(1);
    });
  });
}
