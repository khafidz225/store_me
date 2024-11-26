import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store_me/features/auth/domain/usecases/auth_usecase.dart';

import '../../../../core/di/depedency_injection.dart';
import '../../../../core/enum/condition_state_enum.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/triger_snackbar_error.dart';
import '../../../../core/router/app_pages.dart';
import '../../../../core/widget/snackbar_custom.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AuthLoginEvent>(authLogin);
  }
  Future authLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(conditionStateEnum: ConditionStateEnum.loading));

    final response = await locator<AuthUsecase>()
        .postLogin(username: event.username, password: event.password);

    response.fold(
      (error) {
        TrigerError().trigerSnackbarError(
            context: event.context, error: error, title: 'Failed Login');
        if (error is ConnectionFailure) {
          emit(state.copyWith(
            conditionStateEnum: ConditionStateEnum.error,
            errorMessage: error.message,
          ));
        } else if (error is ServerFailure) {
          emit(state.copyWith(
            conditionStateEnum: ConditionStateEnum.error,
            errorMessage: error.message,
          ));
        } else if (error is GeneralFailure) {
          emit(state.copyWith(
            conditionStateEnum: ConditionStateEnum.error,
            errorMessage: error.message,
          ));
        } else {
          emit(state.copyWith(
            conditionStateEnum: ConditionStateEnum.error,
            errorMessage: 'Failed Login',
          ));
          SnackbarCustom(context: event.context)
              .error(title: 'Failed Login', desc: error.toString());
        }
      },
      (data) {
        emit(state.copyWith(
          conditionStateEnum: ConditionStateEnum.success,
        ));
        SnackbarCustom(context: event.context)
            .success(title: 'Success Login', desc: 'Welcome to Store Me');
        event.context.go(Routes.HOME);
      },
    );
  }
}
