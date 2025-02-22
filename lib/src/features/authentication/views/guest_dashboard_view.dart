import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itc_app/routes/app_routes.dart';
import 'package:itc_app/src/shared/ui/widgets/card_guest.dart';
import '/controllers/auth_controller.dart'; // Import your auth controller

class GuestDashboardView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  GuestDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  "Guest Dashboard",
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
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
          children: [
            buildCard(
              context,
              image: "assets/images/form.png",
              title: "Inquiry Form",
              onTap: () {
                Get.toNamed(AppRoutes.guestForm);
              },
            ),
            buildCard(
              context,
              image: "assets/images/course.png",
              title: "Courses Info.",
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
