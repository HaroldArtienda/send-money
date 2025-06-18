import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/transaction/bloc/transaction_event.dart';
import 'package:send_money/transaction/bloc/transaction_state.dart';

import '../interactor/transaction_interactor.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionInteractor interactor;

  TransactionBloc(this.interactor) : super(TransactionState.initial()) {
    on<LoadTransactions>(_loadTransactions);
    add(LoadTransactions());
  }

  Future<void> _loadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final transactions = await interactor.getTransactions();
      emit(state.copyWith(transactions: transactions, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
