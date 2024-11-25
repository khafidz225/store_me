part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetPhotosEvent extends HomeEvent {
  BuildContext context;
  bool isRender;
  HomeGetPhotosEvent({required this.context, required this.isRender});
  @override
  List<Object> get props => [context, isRender];
}

class HomeLoadMoreEvent extends HomeEvent {
  BuildContext context;

  HomeLoadMoreEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class HomeGetPhotoDetailEvent extends HomeEvent {
  BuildContext context;
  Photo valuePhotoDetail;
  HomeGetPhotoDetailEvent(
      {required this.context, required this.valuePhotoDetail});
  @override
  List<Object> get props => [context, valuePhotoDetail];
}

class HomeDetailScrollPositionChanged extends HomeEvent {
  final double offset;

  const HomeDetailScrollPositionChanged(this.offset);

  @override
  List<Object> get props => [offset];
}
