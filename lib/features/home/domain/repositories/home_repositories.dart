import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/data/models/response/get_res_all_user.dart';
import '../../data/models/response/get_res_product_model.dart';
import '../entities/home_init_entities.dart';

abstract class HomeRepositories {
  Future<Either<Failure, HomeInitEntities>> getHomeInit();
  Future<Either<Failure, List<GetResProductModel>>> getProduct();
  Future<Either<Failure, List<GetResProductModel>>> getProductFromCategory(
      {required String category});
  Future<Either<Failure, List<String>>> getCategory();
  Future<Either<Failure, GetResAllUser>> getMyProfile();
}
