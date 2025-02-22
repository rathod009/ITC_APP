import 'package:get/get.dart';
import 'package:itc_app/src/features/authentication/usecases/verify_user_existence_usecase.dart';
import 'package:itc_app/src/features/authentication/repositories/auth-repository.dart';
import 'package:itc_app/src/features/authentication/viewmodels/authentication_viewmodel.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());

    Get.lazyPut(() => VerifyUserExistenceUseCase(repository: Get.find<AuthRepository>()));

    Get.lazyPut(() => AuthenticationViewModel(
      verifyUserExistenceUseCase: Get.find<VerifyUserExistenceUseCase>(),
    ));
  }
}
