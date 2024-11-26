import 'package:store_me/core/error/failure.dart';
import 'package:store_me/core/service/network_service.dart';
import 'package:store_me/features/auth/data/models/response/get_res_all_user.dart';
import 'package:store_me/features/home/data/datasources/home_remote_datasource.dart';

import 'package:dartz/dartz.dart';
import 'package:store_me/features/home/data/models/response/get_res_product_model.dart';
import 'package:store_me/features/home/domain/entities/home_init_entities.dart';

import '../../../../core/error/exception.dart';
import '../../domain/repositories/home_repositories.dart';

class HomeRepositoriesImpl extends HomeRepositories {
  final NetworkService networkService;
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoriesImpl(
      {required this.networkService, required this.homeRemoteDatasource});

  @override
  Future<Either<Failure, HomeInitEntities>> getHomeInit() async {
    try {
      bool isConnected = true;

      isConnected = await networkService.isConnected;
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'No Internet Connection'));
      }

      List<GetResProductModel>? valueProduct =
          await homeRemoteDatasource.getProduct();
      List<String>? valueCategory = await homeRemoteDatasource.getCategory();
      GetResAllUser? valueProfile = await homeRemoteDatasource.getMyProfile();

      valueCategory.insert(0, 'All');

      HomeInitEntities valueEntities = HomeInitEntities(
          product: valueProduct, category: valueCategory, user: valueProfile);

      return Right(valueEntities);
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

  @override
  Future<Either<Failure, List<GetResProductModel>>> getProduct() async {
    try {
      bool isConnected = true;

      isConnected = await networkService.isConnected;
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'No Internet Connection'));
      }

      List<GetResProductModel>? valueRemote =
          await homeRemoteDatasource.getProduct();
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

  @override
  Future<Either<Failure, List<String>>> getCategory() async {
    try {
      bool isConnected = true;

      isConnected = await networkService.isConnected;
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'No Internet Connection'));
      }

      List<String>? valueRemote = await homeRemoteDatasource.getCategory();
      valueRemote.insert(0, 'All');
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

  @override
  Future<Either<Failure, GetResAllUser>> getMyProfile() async {
    try {
      bool isConnected = true;

      isConnected = await networkService.isConnected;
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'No Internet Connection'));
      }

      GetResAllUser valueRemote = await homeRemoteDatasource.getMyProfile();
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

  @override
  Future<Either<Failure, List<GetResProductModel>>> getProductFromCategory(
      {required String category}) async {
    try {
      bool isConnected = true;

      isConnected = await networkService.isConnected;
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'No Internet Connection'));
      }

      List<GetResProductModel>? valueRemote =
          await homeRemoteDatasource.getProductFromCategory(category: category);
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
