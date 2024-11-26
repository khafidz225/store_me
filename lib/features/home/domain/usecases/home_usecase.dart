import 'package:store_me/features/home/domain/entities/home_init_entities.dart';
import 'package:store_me/features/home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/data/models/response/get_res_all_user.dart';
import '../../data/models/response/get_res_photos_model.dart';
import '../../data/models/response/get_res_product_model.dart';

class HomeUsecase {
  final HomeRepositories homeRepositories;

  HomeUsecase({required this.homeRepositories});
  Future<Either<Failure, HomeInitEntities>> getHomeInit() =>
      homeRepositories.getHomeInit();
  Future<Either<Failure, List<GetResProductModel>>> getProduct() =>
      homeRepositories.getProduct();
  Future<Either<Failure, List<GetResProductModel>>> getProductFromCategory(
          {required String category}) =>
      homeRepositories.getProductFromCategory(category: category);
  Future<Either<Failure, List<String>>> getCategory() =>
      homeRepositories.getCategory();
  Future<Either<Failure, GetResAllUser>> getMyProfile() =>
      homeRepositories.getMyProfile();
}
