import 'package:dartz/dartz.dart';
import 'package:store_me/features/auth/domain/repositories/auth_repositories.dart';

import '../../../../core/error/failure.dart';

class AuthUsecase {
  final AuthRepositories authRepositories;

  AuthUsecase({required this.authRepositories});

  Future<Either<Failure, String>> postLogin(
          {required String username, required String password}) =>
      authRepositories.postLogin(username: username, password: password);
}
