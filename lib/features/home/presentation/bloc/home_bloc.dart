import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_me/core/enum/condition_state_enum.dart';
import 'package:store_me/core/enum/key_local_storage_enum.dart';
import 'package:store_me/core/router/app_pages.dart';
import 'package:store_me/features/home/data/models/response/get_res_product_model.dart';
import 'package:store_me/features/home/domain/entities/home_count_product_cart.dart';
import 'package:store_me/features/home/domain/usecases/home_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/depedency_injection.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/triger_snackbar_error.dart';
import '../../../../core/widget/snackbar_custom.dart';
import '../../../auth/data/models/response/get_res_all_user.dart';

import '../../domain/entities/home_cart_entities.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeInitEvent>(homeInit);
    on<HomeChangeCategoryEvent>(homeChangeCategory);
    on<HomeProductDetailEvent>(homeProductDetail);
    on<HomeDetailScrollPositionChanged>(homeDetailScrollPositionChanged);
    on<HomeChangeBottomNavigationEvent>(homeChangeBottomNavigation);
    on<HomeAddCartEvent>(homeAddCart);
    on<HomeUpdateCartEvent>(homeUpdateCart);
    on<HomeCheckoutCartEvent>(homeCheckoutCart);
    on<HomeLogoutEvent>(homeLogout);
  }

  Future homeInit(HomeInitEvent event, Emitter<HomeState> emit) async {
    if (event.isRender) {
      emit(state.copyWith(conditionStateEnum: ConditionStateEnum.loading));
      final response = await locator<HomeUsecase>().getHomeInit();
      response.fold(
        (error) {
          TrigerError().trigerSnackbarError(
            context: event.context,
            error: error,
            title: 'Home Init',
          );
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
              errorMessage: 'Home Init',
            ));
            SnackbarCustom(context: event.context)
                .error(title: 'Home Init', desc: error.toString());
          }
        },
        (data) {
          emit(state.copyWith(
              conditionStateEnum: ConditionStateEnum.success,
              valueListCategory: data.category,
              valueListProduct: data.product,
              valueMyProfile: data.user,
              activeCategory: 'All',
              indexBottomNavigation: 0));
        },
      );
    }
  }

  Future homeChangeCategory(HomeChangeCategoryEvent event, Emitter emit) async {
    emit(state.copyWith(
      conditionStateEnum: ConditionStateEnum.loadingCard,
      activeCategory: event.activeCategory,
    ));
    final response = event.activeCategory.toLowerCase() != 'all'
        ? await locator<HomeUsecase>()
            .getProductFromCategory(category: event.activeCategory)
        : await locator<HomeUsecase>().getProduct();

    response.fold(
      (error) {
        TrigerError().trigerSnackbarError(
          context: event.context,
          error: error,
          title: 'Home Change Category',
        );
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
              activeCategory: 'All'));
        } else {
          emit(state.copyWith(
            conditionStateEnum: ConditionStateEnum.error,
            activeCategory: 'All',
            errorMessage: 'Home Change Category',
          ));
          SnackbarCustom(context: event.context)
              .error(title: 'Home Change Category', desc: error.toString());
        }
      },
      (data) {
        emit(state.copyWith(
          conditionStateEnum: ConditionStateEnum.success,
          valueListProduct: data,
        ));
      },
    );
  }

  Future homeProductDetail(
      HomeProductDetailEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(valueProductDetail: event.productDetail));
    event.context.push(Routes.HOME_DETAIL);
  }

  Future homeDetailScrollPositionChanged(
      HomeDetailScrollPositionChanged event, Emitter<HomeState> emit) async {
    double newOffset = event.offset > 200 ? 200 : event.offset;
    emit(state.copyWith(scrollHomeDetailOffset: newOffset));
  }

  Future homeChangeBottomNavigation(
      HomeChangeBottomNavigationEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(indexBottomNavigation: event.index));
  }

  Future homeAddCart(HomeAddCartEvent event, Emitter<HomeState> emit) async {
    try {
      HomeProductItemEntities? existingItem;
      if (state.valueCart?.items != null) {
        for (var value in state.valueCart!.items) {
          if (value.product.id == event.value.id) {
            existingItem = value;
            break;
          }
        }
      }

      if (existingItem != null) {
        final updatedItems = state.valueCart?.items.map((item) {
          if (item.product.id == event.value.id) {
            return HomeProductItemEntities(
                product: item.product, count: item.count + 1);
          }
          return item;
        }).toList();

        emit(state.copyWith(
            valueCart: state.valueCart?.copyWith(items: updatedItems)));
      } else {
        HomeCartEntities cart = state.valueCart ?? HomeCartEntities(items: []);
        final updatedItems = List<HomeProductItemEntities>.from(cart.items)
          ..add(HomeProductItemEntities(product: event.value, count: 1));

        emit(state.copyWith(valueCart: cart.copyWith(items: updatedItems)));
      }

      SnackbarCustom(context: event.context).success(
          title: 'Successfully added Product',
          desc: 'Successfully added Product to Cart');
      event.context.push(Routes.HOME);
    } catch (e) {
      debugPrint('Error Add Cart: $e');
    }
  }

  Future homeUpdateCart(
      HomeUpdateCartEvent event, Emitter<HomeState> emit) async {
    final updatedItems = state.valueCart?.items
            .map((item) {
              if (item.product.id == event.value.id) {
                if (event.count == 0) {
                  // Jika count 0, hapus item dari daftar
                  return null; // Mengembalikan null untuk item yang harus dihapus
                } else {
                  // Update item count
                  return HomeProductItemEntities(
                      product: item.product, count: event.count);
                }
              }
              return item;
            })
            .where((item) => item != null)
            .cast<HomeProductItemEntities>()
            .toList() ??
        [];

    emit(state.copyWith(
        valueCart: state.valueCart?.copyWith(items: updatedItems)));
  }

  Future homeCheckoutCart(
      HomeCheckoutCartEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(conditionStateEnum: ConditionStateEnum.loadingButton));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(
        conditionStateEnum: ConditionStateEnum.success,
        valueCart: HomeCartEntities(items: [])));
    SnackbarCustom(context: event.context).success(
        title: 'Successful Checkout',
        desc:
            'You have successfully checked out the goods, please wait for the goods to be sent, thank you');
  }

  Future homeLogout(HomeLogoutEvent event, Emitter<HomeState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(KeyLocalStorageEnum.token.name);
    prefs.remove(KeyLocalStorageEnum.user_id.name);
    SnackbarCustom(context: event.context)
        .success(title: 'Success Logout', desc: '');

    event.context.go(Routes.LOGIN);
  }
}
