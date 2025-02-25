import 'package:itc_app/src/features/authentication/repositories/auth_repository.dart';

class VerifyUserExistenceUseCase {
  final AuthRepository repository;

  VerifyUserExistenceUseCase({required this.repository});

  Future<String?> execute(String username, String password, String userType) async {
    return repository.authenticateUser(username, password, userType);
  }
}