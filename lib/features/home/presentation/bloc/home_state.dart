part of 'home_bloc.dart';

class HomeState {
  ConditionStateEnum? conditionStateEnum;
  String? errorMessage;
  GetResPhotosModel? valueListPhoto;
  Photo? valuePhotoDetail;
  bool? hasFetchedPhotos;
  int? page;

  double? scrollHomeDetailOffset;
  HomeState({
    this.conditionStateEnum,
    this.errorMessage,
    this.valueListPhoto,
    this.valuePhotoDetail,
    this.hasFetchedPhotos,
    this.page,
    this.scrollHomeDetailOffset,
  });

  HomeState copyWith({
    ConditionStateEnum? conditionStateEnum,
    String? errorMessage,
    bool? isLoadMore,
    GetResPhotosModel? valueListPhoto,
    Photo? valuePhotoDetail,
    bool? hasFetchedPhotos,
    int? page,
    double? scrollHomeDetailOffset,
  }) =>
      HomeState(
          conditionStateEnum: conditionStateEnum ?? this.conditionStateEnum,
          errorMessage: errorMessage ?? this.errorMessage,
          valueListPhoto: valueListPhoto ?? this.valueListPhoto,
          valuePhotoDetail: valuePhotoDetail ?? this.valuePhotoDetail,
          hasFetchedPhotos: hasFetchedPhotos ?? this.hasFetchedPhotos,
          page: page ?? this.page,
          scrollHomeDetailOffset:
              scrollHomeDetailOffset ?? this.scrollHomeDetailOffset);

  List<Object?> get props => [
        conditionStateEnum,
        errorMessage,
        valueListPhoto,
        page,
        scrollHomeDetailOffset,
      ];
}
