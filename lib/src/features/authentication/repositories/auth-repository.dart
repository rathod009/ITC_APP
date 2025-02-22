import 'dart:convert';
import 'package:flutter/services.dart';

class AuthRepository {
  Future<Map<String, dynamic>?> getUserCredentials() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/user_credentials.json');
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print("AuthRepository: Error loading credentials: $e");
      return null;
    }
  }

  Future<String?> authenticateUser(String username, String password, String userType) async {
    print("AuthRepository: Attempting to authenticate $username as $userType"); // Log the attempt

    final credentials = await getUserCredentials();
    if (credentials == null) {
      print("AuthRepository: Error - Could not load credentials"); // Log if credentials are null
      return null;
    }

    print("AuthRepository: Credentials loaded successfully"); // Log success

    if (credentials[userType] != null) {
      final userCred = credentials[userType] as Map<String, dynamic>;
      print("AuthRepository: Checking credentials for $userType"); // Log the user type

      if (username == userCred['username'] && password == userCred['password']) {
        print("AuthRepository: Authentication successful for $username as $userType"); // Log success
        return userType;
      } else {
        print("AuthRepository: Authentication failed for $username as $userType (Incorrect username or password)"); // Log failure
      }
    } else {
      print("AuthRepository: No credentials found for user type $userType"); // Log if user type is not found
    }

    print("AuthRepository: Authentication failed for $username as $userType"); // Log overall failure
    return null;
  }
}