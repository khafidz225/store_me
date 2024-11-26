part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitEvent extends HomeEvent {
  BuildContext context;
  bool isRender;
  HomeInitEvent({required this.context, required this.isRender});
  @override
  List<Object> get props => [context, isRender];
}

class HomeChangeCategoryEvent extends HomeEvent {
  BuildContext context;
  String activeCategory;
  HomeChangeCategoryEvent(
      {required this.context, required this.activeCategory});
  @override
  List<Object> get props => [context, activeCategory];
}

class HomeProductDetailEvent extends HomeEvent {
  BuildContext context;
  GetResProductModel productDetail;
  HomeProductDetailEvent({required this.context, required this.productDetail});
  @override
  List<Object> get props => [context, productDetail];
}

class HomeDetailScrollPositionChanged extends HomeEvent {
  final double offset;

  const HomeDetailScrollPositionChanged(this.offset);

  @override
  List<Object> get props => [offset];
}

class HomeChangeBottomNavigationEvent extends HomeEvent {
  final BuildContext context;
  final int index;

  const HomeChangeBottomNavigationEvent(
      {required this.context, required this.index});
  @override
  List<Object> get props => [context, index];
}

class HomeAddCartEvent extends HomeEvent {
  final BuildContext context;
  final GetResProductModel value;

  const HomeAddCartEvent({required this.context, required this.value});
  @override
  List<Object> get props => [context, value];
}

class HomeUpdateCartEvent extends HomeEvent {
  final BuildContext context;
  final GetResProductModel value;
  final int count;

  const HomeUpdateCartEvent(
      {required this.context, required this.value, required this.count});
  @override
  List<Object> get props => [context, value];
}

class HomeCheckoutCartEvent extends HomeEvent {
  final BuildContext context;

  const HomeCheckoutCartEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class HomeLogoutEvent extends HomeEvent {
  final BuildContext context;

  const HomeLogoutEvent({required this.context});
  @override
  List<Object> get props => [context];
}
