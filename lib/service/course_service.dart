import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itc_app/src/features/authentication/models/data_model.dart';

class CourseService {
  Future<List<Course>> fetchCourses() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/courses'));

      // print('Response Status Code: ${response.statusCode}'); // Log status code
      // print('Response Headers: ${response.headers}'); // Log headers
      // print('Response Body: ${response.body}'); // Log the full body

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Course> courses = body.map((dynamic item) => Course.fromJson(item)).toList();
        return courses;
      } else {
        throw Exception('Failed to load courses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API call: $e');
      throw Exception('Failed to load courses. Network error or invalid URL.');
    }
  }
}