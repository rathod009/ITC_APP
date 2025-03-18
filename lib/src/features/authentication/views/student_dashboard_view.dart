import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itc_app/controllers/auth_controller.dart';
import 'package:itc_app/src/shared/ui/widgets/card_student.dart';
// import 'package:itc_app/routes/app_routes.dart';

class StudentDashboardView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  StudentDashboardView({super.key});

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
                  "Student Dashboard",
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
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: const Icon(Icons.logout),
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            buildCard(
              context,
              image: "assets/images/attendance.png",
              title: "ATTENDANCE",
              onTap: () {
                // Navigate to attendance page
                // Example: Get.toNamed(AppRoutes.studentAttendance);
                // Replace AppRoutes.studentAttendance with your actual route
                Get.snackbar("Functionality not implemented", "Attendance page not implemented");
              },
            ),
            buildCard(
              context,
              image: "assets/images/assignment.png",
              title: "ASSIGNMENTS",
              onTap: () {
                // Navigate to assignments page
                // Example: Get.toNamed(AppRoutes.studentAssignments);
                 // Replace AppRoutes.studentAssignments with your actual route
                Get.snackbar("Functionality not implemented", "Assignments page not implemented");
              },
            ),
            buildCard(
              context,
              image: "assets/images/study.png",
              title: "COURSE",
              onTap: () {
                // Navigate to course page
                // Example: Get.toNamed(AppRoutes.studentCourse);
                 // Replace AppRoutes.studentCourse with your actual route
                Get.snackbar("Functionality not implemented", "Course page not implemented");
              },
            ),
            buildCard(
              context,
              image: "assets/images/examination.png",
              title: "EXAMINATION",
              onTap: () {
                // Navigate to examination page
                // Example: Get.toNamed(AppRoutes.studentExamination);
                 // Replace AppRoutes.studentExamination with your actual route
                Get.snackbar("Functionality not implemented", "Examination page not implemented");
              },
            ),
            buildCard(
              context,
              image: "assets/images/project.png",
              title: "PROJECT",
              onTap: () {
                // Navigate to project page
                // Example: Get.toNamed(AppRoutes.studentProject);
                 // Replace AppRoutes.studentProject with your actual route
                Get.snackbar("Functionality not implemented", "Project page not implemented");
              },
            ),
            buildCard(
              context,
              image: "assets/images/quiz.png",
              title: "QUIZ",
              onTap: () {
                // Navigate to quiz page
                // Example: Get.toNamed(AppRoutes.studentQuiz);
                 // Replace AppRoutes.studentQuiz with your actual route
                Get.snackbar("Functionality not implemented", "Quiz page not implemented");
              },
            ),
            buildCard(
              context,
              image: "assets/images/seminar.png",
              title: "SEMINAR",
              onTap: () {
                // Navigate to seminar page
                // Example: Get.toNamed(AppRoutes.studentSeminar);
                 // Replace AppRoutes.studentSeminar with your actual route
                Get.snackbar("Functionality not implemented", "Seminar page not implemented");
              },
            ),
          ],
        ),
      ),
    );
  }
}