import 'package:store_me/core/error/failure.dart';
import 'package:store_me/core/service/network_service.dart';
import 'package:store_me/features/home/data/datasources/home_remote_datasource.dart';
import 'package:store_me/features/home/data/models/response/get_res_photos_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../domain/repositories/home_repositories.dart';

class HomeRepositoriesImpl extends HomeRepositories {
  final NetworkService networkService;
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoriesImpl(
      {required this.networkService, required this.homeRemoteDatasource});

  @override
  Future<Either<Failure, GetResPhotosModel>> getPhotos(
      {required int perPage, required int page}) async {
    try {
      bool isConnected = true;

      isConnected = await networkService.isConnected;
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'No Internet Connection'));
      }

      GetResPhotosModel? valueRemote =
          await homeRemoteDatasource.getPhotos(perPage: perPage, page: page);
      return Right(valueRemote);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on GeneralException catch (error) {
      return Left(GeneralFailure(message: error.message));
    } on ConnectionException catch (error) {
      return Left(ConnectionFailure(message: error.message));
    } catch (error) {
      return Left(GeneralFailure(message: error.toString()));
    }
  }
}
