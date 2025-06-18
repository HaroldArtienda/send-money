import 'package:equatable/equatable.dart';

import '../../dto/transaction.dart';

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final bool isLoading;

  const TransactionState({
    required this.transactions,
    required this.isLoading,
  });

  TransactionState copyWith({
    List<Transaction>? transactions,
    bool? isLoading,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory TransactionState.initial() => TransactionState(
        transactions: [],
        isLoading: false,
      );

  @override
  List<Object?> get props => [transactions, isLoading];
}
