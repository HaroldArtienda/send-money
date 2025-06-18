import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money/home/bloc/home_bloc.dart';
import 'package:send_money/home/bloc/home_event.dart';
import 'package:send_money/home/bloc/home_state.dart';

import '../mocks/home_mocks.mocks.dart';

main() {
  final double fakeMoney = 124590.91;
  late HomeBloc bloc;
  late MockHomeInteractor mockHomeInteractor;

  setUp(() {
    mockHomeInteractor = MockHomeInteractor();
    when(mockHomeInteractor.getWallet()).thenAnswer((_) async => fakeMoney);
    bloc = HomeBloc(mockHomeInteractor);
  });

  tearDown(() {
    bloc.close();
  });

  group('HomeBloc', () {

    blocTest('emit success walletMoney',
        build: () {
          when(mockHomeInteractor.getWallet()).thenAnswer((_) async {
            return fakeMoney;
          });
          return HomeBloc(mockHomeInteractor);
        },
        expect: () => [
              HomeState(walletMoney: 0.0, isLoading: true, error: ''),
              HomeState(walletMoney: fakeMoney, isLoading: false, error: '')
            ],
        verify: (_) {
          verify(mockHomeInteractor.getWallet()).called(2);
        });

    blocTest('emit success walletMoney is 0',
        build: () {
          when(mockHomeInteractor.getWallet()).thenAnswer((_) async {
            return 0;
          });
          return HomeBloc(mockHomeInteractor);
        },
        expect: () => [
          HomeState(walletMoney: 0.0, isLoading: true, error: ''),
          HomeState(walletMoney: 0.0, isLoading: false, error: '')
        ],
        verify: (_) {
          verify(mockHomeInteractor.getWallet()).called(2);
        });
  });
}
