import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repositories_impl.dart';
import '../../features/auth/domain/repositories/auth_repositories.dart';
import '../../features/auth/domain/usecases/auth_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repositories_impl.dart';
import '../../features/home/domain/repositories/home_repositories.dart';
import '../../features/home/domain/usecases/home_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../service/dio_service.dart';
import '../service/network_service.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton<NetworkService>(
    () => NetworkServiceImpl(
      connectivity: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => Connectivity(),
  );
  locator.registerFactory<Dio>(() => DioService(Dio()).dio);

  //HOME
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(),
  );
  locator.registerLazySingleton<AuthRepositories>(
    () => AuthRepositoriesImpl(
        networkService: locator(), authRemoteDatasource: locator()),
  );
  locator.registerLazySingleton<AuthUsecase>(
    () => AuthUsecase(authRepositories: locator()),
  );
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc());
  //HOME
  locator.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(),
  );
  locator.registerLazySingleton<HomeRepositories>(
    () => HomeRepositoriesImpl(
        networkService: locator(), homeRemoteDatasource: locator()),
  );
  locator.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(homeRepositories: locator()),
  );
  locator.registerLazySingleton<HomeBloc>(() => HomeBloc());
}
