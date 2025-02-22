import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itc_app/controllers/auth_controller.dart';
// import 'package:itc_app/routes/app_routes.dart';
import 'package:itc_app/src/shared/ui/widgets/card_faculty.dart';

class FacultyDashboardView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  FacultyDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                'assets/images/itc.png',
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            const Flexible(
              child: Center(
                child: Text(
                  "Faculty Dashboard",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
          children: [
            buildFacultyCard( // Use your faculty card widget
              context,
              image: "assets/images/student_list.png", // Replace with your image
              title: "Student List",
              onTap: () {
                // Navigate to student list page
                // Example: Get.toNamed(AppRoutes.studentList);
                // Replace AppRoutes.studentList with your route
                Get.snackbar("Functionality not implemented", "Student list page not implemented");
              },
            ),
            buildFacultyCard( // Use your faculty card widget
              context,
              image: "assets/images/attendance.png", // Replace with your image
              title: "Attendance",
              onTap: () {
                // Navigate to attendance page
                // Example: Get.toNamed(AppRoutes.attendance);
                // Replace AppRoutes.attendance with your route.
                Get.snackbar("Functionality not implemented", "Attendance page not implemented");
              },
            ),
            buildFacultyCard( // Use your faculty card widget
              context,
              image: "assets/images/batches.png", // Replace with your image
              title: "Batches",
              onTap: () {
                 // Navigate to grades page
                // Example: Get.toNamed(AppRoutes.grades);
                // Replace AppRoutes.grades with your route.
                Get.snackbar("Functionality not implemented", "Batches page not implemented");
              },
            ),
            buildFacultyCard( // Use your faculty card widget
              context,
              image: "assets/images/lecture.png", // Replace with your image
              title: "Lectures",
              onTap: () {
                 // Navigate to grades page
                // Example: Get.toNamed(AppRoutes.grades);
                // Replace AppRoutes.grades with your route.
                Get.snackbar("Functionality not implemented", "Lectures page not implemented");
              },
            ),
            // Add more cards for faculty functionalities
          ],
        ),
      ),
    );
  }
}
