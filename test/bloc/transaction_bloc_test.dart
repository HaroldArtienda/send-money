import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/dto/transaction.dart';
import 'package:send_money/transaction/bloc/transaction_bloc.dart';
import 'package:send_money/transaction/bloc/transaction_state.dart';

import '../mocks/transaction_mocks.mocks.dart';

void main() {
  late TransactionBloc bloc;
  late MockTransactionInteractor mockInteractor;

  final List<Transaction> fakeTransactions = [
    Transaction(
      id: '1',
      transactionId: 'TX001',
      transactionAmount: 100.0,
      date: DateTime.parse("2024-10-01T10:08:52.759Z"),
      transactionType: 'deposit',
    ),
    Transaction(
      id: '2',
      transactionId: 'TX002',
      transactionAmount: 200.0,
      date: DateTime.parse("2024-06-01T11:08:52.759Z"),
      transactionType: 'payment',
    ),
  ];

  setUp(() {
    mockInteractor = MockTransactionInteractor();
    when(mockInteractor.getTransactions())
        .thenAnswer((_) async => fakeTransactions);
    bloc = TransactionBloc(mockInteractor);
  });

  tearDown(() {
    bloc.close();
  });

  group('TransactionBloc', () {
    blocTest<TransactionBloc, TransactionState>(
      'emit success when transactions are fetched',
      build: () {
        when(mockInteractor.getTransactions())
            .thenAnswer((_) async => fakeTransactions);
        return TransactionBloc(mockInteractor);
      },
      expect: () => [
        TransactionState(transactions: [], isLoading: true),
        TransactionState(transactions: fakeTransactions, isLoading: false),
      ],
      verify: (_) {
        verify(mockInteractor.getTransactions()).called(2);
      },
    );

    blocTest<TransactionBloc, TransactionState>(
      'emit success when getTransactions returns empty list',
      build: () {
        when(mockInteractor.getTransactions()).thenAnswer((_) async => []);
        return TransactionBloc(mockInteractor);
      },
      expect: () => [
        TransactionState(transactions: [], isLoading: true),
        TransactionState(transactions: [], isLoading: false),
      ],
      verify: (_) {
        verify(mockInteractor.getTransactions()).called(2);
      },
    );

    blocTest<TransactionBloc, TransactionState>(
      'emit not loading when getTransactions throws',
      build: () {
        when(mockInteractor.getTransactions())
            .thenThrow(Exception('Failed to load'));
        return TransactionBloc(mockInteractor);
      },
      expect: () => [
        TransactionState(transactions: [], isLoading: true),
        TransactionState(transactions: [], isLoading: false),
      ],
      verify: (_) {
        verify(mockInteractor.getTransactions()).called(2);
      },
    );
  });
}
