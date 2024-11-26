part of 'home_bloc.dart';

class HomeState {
  ConditionStateEnum? conditionStateEnum;
  String? errorMessage;
  List<GetResProductModel>? valueListProduct;
  List<String>? valueListCategory;
  GetResProductModel? valueProductDetail;
  HomeCartEntities? valueCart;
  GetResAllUser? valueMyProfile;
  double? scrollHomeDetailOffset;
  String? activeCategory;

  int? indexBottomNavigation;
  HomeState(
      {this.conditionStateEnum,
      this.errorMessage,
      this.scrollHomeDetailOffset,
      this.valueListCategory,
      this.valueListProduct,
      this.valueProductDetail,
      this.valueCart,
      this.valueMyProfile,
      this.activeCategory,
      this.indexBottomNavigation});

  HomeState copyWith({
    ConditionStateEnum? conditionStateEnum,
    String? errorMessage,
    bool? isLoadMore,
    List<GetResProductModel>? valueListProduct,
    List<String>? valueListCategory,
    GetResProductModel? valueProductDetail,
    HomeCartEntities? valueCart,
    GetResAllUser? valueMyProfile,
    double? scrollHomeDetailOffset,
    String? activeCategory,
    int? indexBottomNavigation,
  }) {
    print(
        'Copying HomeState: original valueCart=${this.valueCart?.items.length}, new valueCart=${valueCart?.items.length}');
    return HomeState(
      conditionStateEnum: conditionStateEnum ?? this.conditionStateEnum,
      errorMessage: errorMessage ?? this.errorMessage,
      valueListCategory: valueListCategory ?? this.valueListCategory,
      valueListProduct: valueListProduct ?? this.valueListProduct,
      valueProductDetail: valueProductDetail ?? this.valueProductDetail,
      valueCart: valueCart ?? this.valueCart,
      valueMyProfile: valueMyProfile ?? this.valueMyProfile,
      scrollHomeDetailOffset:
          scrollHomeDetailOffset ?? this.scrollHomeDetailOffset,
      activeCategory: activeCategory ?? this.activeCategory,
      indexBottomNavigation:
          indexBottomNavigation ?? this.indexBottomNavigation,
    );
  }

  List<Object?> get props => [
        conditionStateEnum,
        errorMessage,
        scrollHomeDetailOffset,
        valueListCategory,
        valueListProduct,
        valueProductDetail,
        valueCart,
        valueMyProfile,
        activeCategory,
        indexBottomNavigation
      ];
}
