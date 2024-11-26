import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepositories {
  Future<Either<Failure, String>> postLogin(
      {required String username, required String password});
}
