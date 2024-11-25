import 'package:store_me/core/enum/condition_state_enum.dart';
import 'package:store_me/core/router/app_pages.dart';
import 'package:store_me/features/home/domain/usecases/home_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/depedency_injection.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/triger_snackbar_error.dart';
import '../../../../core/widget/snackbar_custom.dart';
import '../../data/models/response/get_res_photos_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeGetPhotosEvent>(homeGetPhotos);
    on<HomeLoadMoreEvent>(homeLoadMore);
    on<HomeGetPhotoDetailEvent>(homeGetPhotoDetail);
    on<HomeDetailScrollPositionChanged>(homeDetailScrollPositionChanged);
  }

  Future homeGetPhotos(
      HomeGetPhotosEvent event, Emitter<HomeState> emit) async {
    if (state.hasFetchedPhotos == null || event.isRender == true) {
      emit(state.copyWith(conditionStateEnum: ConditionStateEnum.loading));
      final response =
          await locator<HomeUsecase>().getPhotos(perPage: 30, page: 1);

      response.fold(
        (error) {
          TrigerError().trigerSnackbarError(
              context: event.context, error: error, title: 'Failed Get Photos');
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
              errorMessage: 'Failed Get Photos',
            ));
            SnackbarCustom(context: event.context)
                .error(title: 'Failed Get Photos', desc: error.toString());
          }
        },
        (data) {
          emit(state.copyWith(
              conditionStateEnum: ConditionStateEnum.success,
              valueListPhoto: data,
              hasFetchedPhotos: false,
              page: 1));
        },
      );
    }
  }

  Future homeLoadMore(HomeLoadMoreEvent event, Emitter<HomeState> emit) async {
    int page = state.page!;
    emit(state.copyWith(conditionStateEnum: ConditionStateEnum.loadingMore));
    page++;
    final response =
        await locator<HomeUsecase>().getPhotos(perPage: 30, page: page);

    response.fold(
      (error) {
        TrigerError().trigerSnackbarError(
            context: event.context,
            error: error,
            title: 'Failed Load More Photos');
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
            errorMessage: 'Failed Load More Photos',
          ));
          SnackbarCustom(context: event.context)
              .error(title: 'Failed Load More Photos', desc: error.toString());
        }
      },
      (data) {
        List<Photo> photos = state.valueListPhoto?.photos ?? [];
        photos.addAll(data.photos);

        emit(state.copyWith(
            conditionStateEnum: ConditionStateEnum.success,
            valueListPhoto: data.copyWith(photos: photos),
            hasFetchedPhotos: false,
            page: page));
      },
    );
  }

  Future homeGetPhotoDetail(
      HomeGetPhotoDetailEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(valuePhotoDetail: event.valuePhotoDetail));
    event.context.push(Routes.HOME_DETAIL);
  }

  Future homeDetailScrollPositionChanged(
      HomeDetailScrollPositionChanged event, Emitter<HomeState> emit) async {
    double newOffset = event.offset > 200 ? 200 : event.offset;
    emit(state.copyWith(scrollHomeDetailOffset: newOffset));
  }
}
