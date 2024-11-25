import 'package:store_me/features/auth/data/datasources/auth_remote_datasource.dart';

import '../../../../core/service/network_service.dart';
import '../../domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  final NetworkService networkService;
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoriesImpl(
      {required this.networkService, required this.authRemoteDatasource});
}
