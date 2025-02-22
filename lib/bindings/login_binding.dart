import 'package:get/get.dart';
import '../controllers/login_controller.dart'; // Correct import path

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}