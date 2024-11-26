part of 'auth_bloc.dart';

class AuthState {
  ConditionStateEnum? conditionStateEnum;
  String? errorMessage;

  AuthState({
    this.conditionStateEnum,
    this.errorMessage,
  });

  AuthState copyWith({
    ConditionStateEnum? conditionStateEnum,
    String? errorMessage,
  }) =>
      AuthState(
        conditionStateEnum: conditionStateEnum ?? this.conditionStateEnum,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  List<Object?> get props => [
        conditionStateEnum,
        errorMessage,
      ];
}
