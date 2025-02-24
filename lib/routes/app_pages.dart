import 'package:get/get.dart';
import 'package:itc_app/bindings/authentication_bindings.dart';
import 'package:itc_app/bindings/login_binding.dart';
import 'package:itc_app/src/features/authentication/views/splash_view.dart';
import 'package:itc_app/src/features/authentication/views/login_page.dart';
import 'package:itc_app/src/features/authentication/views/guest_dashboard_view.dart'; // Create these
import 'package:itc_app/src/features/authentication/views/admin_dashboard_view.dart'; // Create these
import 'package:itc_app/src/features/authentication/views/faculty_dashboard_view.dart'; // Create these
import 'package:itc_app/src/features/authentication/views/student_dashboard_view.dart'; // Create these
import 'package:itc_app/src/features/authentication/views/guest_inquiry_form.dart'; // Add this line
import 'package:itc_app/src/features/authentication/views/courses_view.dart'; // Add this line

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.guestDashboard,
      page: () => GuestDashboardView(),
    ),
    GetPage(
      name: AppRoutes.studentDashboard,
      page: () => StudentDashboardView(),
      binding: AuthenticationBinding(), // Add the binding here
    ),
    GetPage(
      name: AppRoutes.facultyDashboard,
      page: () => FacultyDashboardView(),
      binding: AuthenticationBinding(), // Add the binding here
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => AdminDashboardView(),
      binding: AuthenticationBinding(), // Add the binding here
    ),
    GetPage(
      name: AppRoutes.guestForm,
      page: () => GuestInquiryForm(),
    ),
    GetPage(
      name: AppRoutes.courses,
      page: () => CoursesView(),
    ),
    // ... other pages
  ];
}
