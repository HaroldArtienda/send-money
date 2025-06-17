import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool succcess;
  final String error;

  const LoginState({
    required this.isLoading,
    required this.succcess,
    required this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? success,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      succcess: success ?? this.succcess,
      error: error ?? this.error,
    );
  }

  factory LoginState.initial() =>
      LoginState(isLoading: false, succcess: false, error: '');

  @override
  List<Object> get props => [isLoading, succcess, error];
}
