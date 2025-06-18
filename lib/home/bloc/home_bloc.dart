import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/home/bloc/home_event.dart';
import 'package:send_money/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final double money = 124590.91;

  HomeBloc() : super(HomeState.initial()) {
    on<GetWalletMoney>(_getWalletMoney);

    add(GetWalletMoney());
  }

  Future<void> _getWalletMoney(
      GetWalletMoney event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    //fake loading
    await Future.delayed(Duration(milliseconds: 2000));
    emit(state.copyWith(walletMoney: money, isLoading: false));
  }
}
