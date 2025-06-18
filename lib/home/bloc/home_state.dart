import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final double walletMoney;
  final bool isLoading;
  final String error;

  const HomeState({
    required this.walletMoney,
    required this.isLoading,
    required this.error,
  });

  HomeState copyWith({double? walletMoney, bool? isLoading, String? error}) {
    return HomeState(
      walletMoney: walletMoney ?? this.walletMoney,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  factory HomeState.initial() => HomeState(
        walletMoney: 0.0,
        isLoading: false,
        error: "",
      );

  @override
  List<Object?> get props => [
        walletMoney,
        isLoading,
        error,
      ];
}
