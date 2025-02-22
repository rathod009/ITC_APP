import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart'; // Import your routes

class AuthController extends GetxController {
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn.value) {
      // Optionally, navigate to the home screen or dashboard if already logged in
      // Get.offNamed(AppRoutes.home); // Or the appropriate dashboard
    }
  }

  Future<void> login(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setBool('isLoggedIn', true);
    isLoggedIn.value = true;
    Get.offNamed(AppRoutes.login); // Navigate to home or dashboard after login
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.setBool('isLoggedIn', false);
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login); // Navigate to login after logout
  }
}
