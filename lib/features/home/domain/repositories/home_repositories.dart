import 'package:store_me/features/home/data/models/response/get_res_photos_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class HomeRepositories {
  Future<Either<Failure, GetResPhotosModel>> getPhotos(
      {required int perPage, required int page});
}
