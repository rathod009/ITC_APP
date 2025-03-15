// New main.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'controllers/login_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'src/features/authentication/viewmodels/authentication_viewmodel.dart';
import 'src/features/authentication/usecases/verify_user_existence_usecase.dart';
import 'package:itc_app/src/features/authentication/repositories/auth_repository.dart'; // Import your repository

// Custom HttpOverrides class to bypass SSL issues during development
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // Enable HttpOverrides to bypass SSL certificate issues during testing
  HttpOverrides.global = MyHttpOverrides();

  // Create an instance of your repository
  final authRepository = AuthRepository(); // Replace with your repository implementation

  // Create an instance of the use case, providing the repository
  final verifyUserExistenceUseCase = VerifyUserExistenceUseCase(repository: authRepository);

  // Register AuthenticationViewModel with its dependency
  Get.put(AuthenticationViewModel(verifyUserExistenceUseCase: verifyUserExistenceUseCase));

  Get.put(AuthController());
  Get.lazyPut(() => LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Information Technology Centre',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}


// // Original main.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'controllers/auth_controller.dart';
// import 'controllers/login_controller.dart';
// import 'routes/app_pages.dart';
// import 'routes/app_routes.dart';
// import 'src/features/authentication/viewmodels/authentication_viewmodel.dart';
// import 'src/features/authentication/usecases/verify_user_existence_usecase.dart';
// import 'package:itc_app/src/features/authentication/repositories/auth_repository.dart'; // Import your repository

// void main() {
//   // Create an instance of your repository
//   final authRepository = AuthRepository(); // Replace with your repository implementation

//   // Create an instance of the use case, providing the repository
//   final verifyUserExistenceUseCase = VerifyUserExistenceUseCase(repository: authRepository);

//   // Register AuthenticationViewModel with its dependency
//   Get.put(AuthenticationViewModel(verifyUserExistenceUseCase: verifyUserExistenceUseCase));

//   Get.put(AuthController());
//   Get.lazyPut(() => LoginController());
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Information Technology Centre',
//       debugShowCheckedModeBanner: false,
//       initialRoute: AppRoutes.splash,
//       getPages: AppPages.pages,
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'controllers/auth_controller.dart';
// // import 'controllers/login_controller.dart';
// // import 'routes/app_pages.dart'; // Import your app pages
// // import 'routes/app_routes.dart'; // Import your app routes

// // void main() {
// //   Get.put(AuthController()); // Eager initialization for AuthController (if needed)
// //   Get.lazyPut(() => LoginController()); // Lazy initialization for LoginController
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GetMaterialApp(
// //       title: 'Information Technology Centre',
// //       debugShowCheckedModeBanner: false,
// //       initialRoute: AppRoutes.splash,
// //       getPages: AppPages.pages, // Use your AppPages here
// //     );
// //   }
// // }