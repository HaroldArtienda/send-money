import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/dto/transaction.dart';
import 'package:send_money/transaction/interactor/transaction_interactor_impl.dart';
import '../mocks/transaction_mocks.mocks.dart' show MockTransactionService;

void main() {
  late TransactionInteractorImpl interactor;
  late MockTransactionService mockService;

  setUp(() {
    mockService = MockTransactionService();
    interactor = TransactionInteractorImpl(mockService);
  });

  test('should return sorted transactions by date descending', () async {
    final unsortedTransactions = [
      Transaction(
        id: '1',
        transactionId: '111',
        transactionAmount: 100.0,
        date: DateTime.parse('2024-01-01T10:00:00Z'),
        transactionType: 'deposit',
      ),
      Transaction(
        id: '2',
        transactionId: '222',
        transactionAmount: 200.0,
        date: DateTime.parse('2025-01-01T10:00:00Z'),
        transactionType: 'payment',
      ),
    ];

    when(mockService.getTransactions())
        .thenAnswer((_) async => unsortedTransactions);

    final result = await interactor.getTransactions();

    expect(result.length, 2);
    expect(result[0].transactionId, '222'); // latest first
    expect(result[1].transactionId, '111'); // older second
    verify(mockService.getTransactions()).called(1);
  });
}
