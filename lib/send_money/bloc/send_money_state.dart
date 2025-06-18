import 'package:equatable/equatable.dart';
import 'package:send_money/utils/constants.dart';

class SendMoneyState extends Equatable {
  final bool success;
  final String error;
  final SendMoneyStatus status;

  const SendMoneyState({
    required this.success,
    required this.error,
    required this.status,
  });

  SendMoneyState copyWith({
    bool? success,
    String? error,
    SendMoneyStatus? status,
  }) {
    return SendMoneyState(
        success: success ?? this.success,
        error: error ?? this.error,
        status: status ?? this.status);
  }

  factory SendMoneyState.initial() => SendMoneyState(
        success: false,
        error: '',
        status: SendMoneyStatus.notStarted,
      );

  @override
  List<Object?> get props => [
        success,
        error,
        status,
      ];
}
