import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/send_money/bloc/send_money_bloc.dart';
import 'package:send_money/send_money/bloc/send_money_event.dart';
import 'package:send_money/send_money/bloc/send_money_state.dart';
import 'package:send_money/send_money/interactor/send_money_interactor.dart';
import 'package:send_money/utils/constants.dart';

import '../mocks/send_money_mocks.mocks.dart';

main() {
  late SendMoneyBloc sendMoneyBloc;
  late MockSendMoneyInteractor mockSendMoneyInteractor;

  setUp(() {
    mockSendMoneyInteractor = MockSendMoneyInteractor();
    sendMoneyBloc = SendMoneyBloc(mockSendMoneyInteractor);
  });

  tearDown(() {
    sendMoneyBloc.close();
  });

  group('SendMoneyBloc', () {
    blocTest(
      'emit success when amount is valid',
      build: () {
        when(mockSendMoneyInteractor.isValid(any))
            .thenAnswer((_) async => true);
        return SendMoneyBloc(mockSendMoneyInteractor);
      },
      act: (bloc) => bloc.add(SendMoney(100)),
      expect: () => [
        SendMoneyState(
            success: false, error: '', status: SendMoneyStatus.loading),
        SendMoneyState(success: true, error: '', status: SendMoneyStatus.done),
        SendMoneyState(
            success: false, error: '', status: SendMoneyStatus.notStarted),
      ],
      verify: (_) {
        verify(mockSendMoneyInteractor.isValid(100)).called(1);
      },
    );

    blocTest(
      'emit success when amount is invalid',
      build: () {
        when(mockSendMoneyInteractor.isValid(any))
            .thenAnswer((_) async => false);
        return SendMoneyBloc(mockSendMoneyInteractor);
      },
      act: (bloc) => bloc.add(SendMoney(100000)),
      expect: () => [
        SendMoneyState(
            success: false, error: '', status: SendMoneyStatus.loading),
        SendMoneyState(success: false, error: '', status: SendMoneyStatus.done),
        SendMoneyState(
            success: false, error: '', status: SendMoneyStatus.notStarted),
      ],
      verify: (_) {
        verify(mockSendMoneyInteractor.isValid(100000)).called(1);
      },
    );
  });
}
