import 'package:store_me/features/auth/domain/repositories/auth_repositories.dart';

class AuthUsecase {
  final AuthRepositories authRepositories;

  AuthUsecase({required this.authRepositories});
}
