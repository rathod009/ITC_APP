import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itc_app/routes/app_routes.dart';
import 'package:itc_app/src/features/authentication/viewmodels/authentication_viewmodel.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var userType = 'student'.obs; // Or whatever your default user type is
  var obscurePassword = true.obs;
  final isGuestMode = false.obs;

  void login() {
    if (isGuestMode.value) {
      navigateToDashboard('guest');
      return;
    }

    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter username and password');
      return;
    }

    _performAuthentication(username, password);
  }

  Future<void> _performAuthentication(String username, String password) async {
    try {
      final authViewModel = Get.find<AuthenticationViewModel>();

      final userRole = await authViewModel.authenticateUser(username, password, userType.value);

      if (userRole != null) {
        navigateToDashboard(userRole);
      } else {
        Get.snackbar('Error', 'Invalid username or password');
      }
    } catch (e) {
      // print("Authentication error: $e");
      Get.snackbar('Error', 'An error occurred during authentication.');
    }
  }

  void navigateToDashboard(String userRole) {
    switch (userRole) {
      case 'admin':
        Get.offNamed(AppRoutes.adminDashboard);
        break;
      case 'faculty':
        Get.offNamed(AppRoutes.facultyDashboard);
        break;
      case 'student':
        Get.offNamed(AppRoutes.studentDashboard);
        break;
      case 'guest':
        Get.offNamed(AppRoutes.guestDashboard);
        break;
      default:
        // Handle unexpected user roles (optional)
        Get.snackbar('Error', 'Unexpected user role: $userRole');
        break;
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void setUserType(String value) {
    userType.value = value;
  }
}
