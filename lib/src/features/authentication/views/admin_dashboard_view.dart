import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itc_app/routes/app_routes.dart';
import 'package:itc_app/src/shared/ui/widgets/card_admin.dart'; // Ensure correct path
// import 'package:itc_app/src/features/authentication/views/insights_view.dart';
// import 'package:itc_app/src/features/authentication/views/inquiry_form_view.dart';
import '/controllers/auth_controller.dart'; // Import your auth controller

class AdminDashboardView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>(); // Get the auth controller

  AdminDashboardView({super.key});

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
                  "Admin Dashboard",
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
                authController.logout(); // Call logout from auth controller
              },
              icon: const Icon(Icons.logout),
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
          childAspectRatio: 0.9,
          children: [
            // buildCard(
            //   context,
            //   image: "assets/images/insights.png",
            //   title: "View Insights",
            //   onTap: () {
            //     Get.toNamed(AppRoutes.insights);
            //   },
            // ),
            // buildCard(
            //   context,
            //   image: "assets/images/form.png",
            //   title: "Fill Inquiry Data",
            //   onTap: () {
            //     Get.toNamed(AppRoutes.inquiryForm);
            //   },
            // ),
            buildCard(
              context,
              image: "assets/images/course.png",
              title: "Edit Courses",
              onTap: () {
                Get.toNamed(AppRoutes.courses);
              },
            ),
          ],
        ),
      ),
    );
  }
}
