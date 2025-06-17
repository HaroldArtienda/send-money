import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool success;
  final String error;

  const LoginState({
    required this.isLoading,
    required this.success,
    required this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? success,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  factory LoginState.initial() =>
      LoginState(isLoading: false, success: false, error: '');

  @override
  List<Object> get props => [isLoading, success, error];
}
