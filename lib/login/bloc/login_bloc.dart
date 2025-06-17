import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/login/bloc/login_event.dart';
import 'package:send_money/login/bloc/login_state.dart';
import 'package:send_money/login/interactor/login_interactor.dart';
import 'package:send_money/login/interactor/login_interactor_impl.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginInteractor interactor;

  LoginBloc(this.interactor) : super(LoginState.initial()) {
    on<Login>(_login);
  }

  Future<void> _login(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final isEmailCorrect = interactor.isEmailCorrect(event.email);
    final isPasswordCorrect = interactor.isPasswordCorrect(event.password);

    //fake proceed call service here
    await Future.delayed(Duration(milliseconds: 2000));

    if (isPasswordCorrect && isEmailCorrect) {
      emit(state.copyWith(isLoading: false, success: true, error: ""));
    } else {
      emit(state.copyWith(isLoading: false, error: "Invalid Credentials"));
    }

    emit(LoginState.initial());
  }
}
