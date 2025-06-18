import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/home/bloc/home_event.dart';
import 'package:send_money/home/bloc/home_state.dart';
import 'package:send_money/home/interactor/home_interactor.dart';
import 'package:send_money/service/transaction_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final double money = 124590.91;
  late final HomeInteractor interactor;

  HomeBloc(this.interactor) : super(HomeState.initial()) {
    on<GetWalletMoney>(_getWalletMoney);

    add(GetWalletMoney());
  }

  Future<void> _getWalletMoney(
      GetWalletMoney event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final totalAmount = await interactor.getWallet();
      emit(state.copyWith(walletMoney: totalAmount, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
