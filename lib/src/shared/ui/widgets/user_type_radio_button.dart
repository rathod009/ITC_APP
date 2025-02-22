// widgets/user_type_radio_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/login_controller.dart'; // Import your controller

Widget buildUserTypeRadioButton(String value, String label, LoginController controller) {
  return Obx(() => GestureDetector(
        onTap: () => controller.userType.value = value,
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: controller.userType.value,
              onChanged: (newValue) => controller.userType.value = newValue!,
            ),
            Text(label),
          ],
        ),
      ));
}
