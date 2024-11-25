import 'package:store_me/features/home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/response/get_res_photos_model.dart';

class HomeUsecase {
  final HomeRepositories homeRepositories;

  HomeUsecase({required this.homeRepositories});

  Future<Either<Failure, GetResPhotosModel>> getPhotos(
          {required int perPage, required int page}) =>
      homeRepositories.getPhotos(perPage: perPage, page: page);
}
