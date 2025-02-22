import 'package:get/get.dart';
import 'package:itc_app/src/features/authentication/usecases/verify_user_existence_usecase.dart'; // Import the use case

class AuthenticationViewModel extends GetxController {
  final VerifyUserExistenceUseCase verifyUserExistenceUseCase;

  AuthenticationViewModel({
    required this.verifyUserExistenceUseCase,
  });

  Future<String?> authenticateUser(String username, String password, String userType) async {
    return await verifyUserExistenceUseCase.execute(username, password, userType);
  }
}
