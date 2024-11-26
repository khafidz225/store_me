import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_me/core/enum/key_local_storage_enum.dart';
import 'package:store_me/core/error/failure.dart';
import 'package:store_me/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:store_me/features/auth/data/models/response/get_res_all_user.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/service/network_service.dart';
import '../../domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  final NetworkService networkService;
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoriesImpl(
      {required this.networkService, required this.authRemoteDatasource});

  @override
  Future<Either<Failure, String>> postLogin(
      {required String username, required String password}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isConnected = true;

      isConnected = await networkService.isConnected;
      if (isConnected == false) {
        return const Left(ConnectionFailure(message: 'No Internet Connection'));
      }

      String? valueRemote = await authRemoteDatasource.postLogin(
          username: username, password: password);

      List<GetResAllUser> valueAllUser =
          await authRemoteDatasource.getAllUser();

      for (var user in valueAllUser) {
        if (user.username == username && user.password == password) {
          prefs.setString(KeyLocalStorageEnum.user_id.name, user.id.toString());
          prefs.setString(KeyLocalStorageEnum.token.name, valueRemote);

          debugPrint('Success Save User Id In Local Storage');
          break;
        }
      }

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
