import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/login/bloc/login_bloc.dart';
import 'package:send_money/login/bloc/login_event.dart';
import 'package:send_money/login/bloc/login_state.dart';
import 'package:send_money/login/interactor/login_interactor.dart';
import 'package:send_money/login/interactor/login_interactor_impl.dart';

import '../mocks/login_mocks.mocks.dart';

void main() {
  late LoginBloc bloc;
  late MockLoginInteractor mockInteractor;

  setUp(() {
    mockInteractor = MockLoginInteractor();
    bloc = LoginBloc(mockInteractor);
  });

  tearDown(() {
    bloc.close();
  });

  group('LoginBloc', () {
    const validEmail = 'admin@test.com';
    const validPassword = 'test1234!';
    const fakeEmail = 'fake@email.com';
    const fakePassword = 'fakepass1234';

    blocTest<LoginBloc, LoginState>(
      'emit success when credentials are valid',
      build: () {
        when(mockInteractor.isEmailCorrect(any)).thenReturn(true);
        when(mockInteractor.isPasswordCorrect(any)).thenReturn(true);
        return LoginBloc(mockInteractor);
      },
      act: (bloc) => bloc.add(Login(validEmail, validPassword)),
      wait: const Duration(milliseconds: 2200),
      expect: () => [
        LoginState(isLoading: true, success: false, error: ''),
        LoginState(isLoading: false, success: true, error: ''),
        LoginState.initial(),
      ],
    );

    blocTest(
      'emit invalid credentials when email is false',
      build: () {
        when(mockInteractor.isEmailCorrect(any)).thenReturn(false);
        when(mockInteractor.isPasswordCorrect(any)).thenReturn(true);
        return LoginBloc(mockInteractor);
      },
      act: (bloc) => bloc.add(Login(fakeEmail, validPassword)),
      wait: const Duration(milliseconds: 2200),
      expect: () => [
        LoginState(isLoading: true, success: false, error: ''),
        LoginState(
            isLoading: false, success: false, error: 'Invalid Credentials'),
        LoginState.initial(),
      ],
    );

    blocTest(
      'emit invalid credentials when password is false',
      build: () {
        when(mockInteractor.isEmailCorrect(any)).thenReturn(false);
        when(mockInteractor.isPasswordCorrect(any)).thenReturn(true);
        return LoginBloc(mockInteractor);
      },
      act: (bloc) => bloc.add(Login(validEmail, fakePassword)),
      wait: const Duration(milliseconds: 2200),
      expect: () => [
        LoginState(isLoading: true, success: false, error: ''),
        LoginState(
            isLoading: false, success: false, error: 'Invalid Credentials'),
        LoginState.initial(),
      ],
    );

    blocTest(
      'emit invalid credentials when both credential is null',
      build: () {
        when(mockInteractor.isEmailCorrect(null)).thenReturn(false);
        when(mockInteractor.isPasswordCorrect(null)).thenReturn(false);
        return LoginBloc(mockInteractor);
      },
      act: (bloc) => bloc.add(Login(null, null)),
      wait: const Duration(milliseconds: 2200),
      expect: () => [
        LoginState(isLoading: true, success: false, error: ''),
        LoginState(
            isLoading: false, success: false, error: 'Invalid Credentials'),
        LoginState.initial(),
      ],
    );
  });
}
