import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/send_money/bloc/send_money_event.dart';
import 'package:send_money/send_money/bloc/send_money_state.dart';
import 'package:send_money/send_money/interactor/send_money_interactor.dart';
import 'package:send_money/utils/constants.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  late SendMoneyInteractor sendMoneyInteractor;

  SendMoneyBloc(this.sendMoneyInteractor) : super(SendMoneyState.initial()) {
    on<SendMoney>(_sendMoney);
  }

  Future<void> _sendMoney(SendMoney event, Emitter<SendMoneyState> emit) async {
    emit(state.copyWith(status: SendMoneyStatus.loading));
    try {
      final isSuccess = sendMoneyInteractor.isValid(event.amount);

      if (isSuccess) {
        final response =
            await sendMoneyInteractor.sendMoney(event.amount);

        if (response != null) {
          emit(state.copyWith(success: true, status: SendMoneyStatus.done));
        }
      } else {
        emit(state.copyWith(success: false, status: SendMoneyStatus.done));
      }
    } catch (e) {
      emit(state.copyWith(success: false, status: SendMoneyStatus.done));
    } finally {
      emit(SendMoneyState.initial());
    }
  }
}
