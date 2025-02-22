import 'package:flutter/material.dart';
import 'package:itc_app/src/shared/ui/widgets/card_course.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});

  // Course categories
  static const List<String> allCourseCategories = [
    'Accounting',
    'Autodesk',
    'Hardware',
    'Multimedia',
    'Networking',
    'Office Automation',
    'Programming',
    'Spoken English',
    'Internship',
    'Other'
  ];

  // Course descriptions
  static const List<String> allCourseDescriptions = [
  'Learn accounting principles, financial analysis, and budgeting. Build a foundation for a finance career.',
  'Master Autodesk software for 2D/3D modeling in architecture and engineering. Prepare for industry certifications.',
  'Gain hardware knowledge: CPUs, motherboards, memory. Learn to assemble and repair systems for IT careers.',
  'Explore multimedia tools like Photoshop and Premiere Pro. Develop skills in graphics and video editing.',
  'Learn networking concepts, security, and administration. Configure routers and switches for network careers.',
  'Master Microsoft Office Suite for document creation, data analysis, and presentations in office environments.',
  'Learn programming languages like Python and Java. Develop skills in software and app development.',
  'Improve spoken English: pronunciation, grammar, vocabulary. Practice for presentations and interviews.',
  'Gain practical experience through internships. Apply skills in real-world settings and build your network.',
  'Explore specialized courses like data science and web development. Learn emerging technologies.',
];

  // Course durations
  static const List<String> allCourseDurations = [
    '3 Months',
    '4 Months',
    '2 Months',
    '3 Months',
    '4 Months',
    '2 Months',
    '3 Months',
    '2 Months',
    'Variable',
    'Variable',
  ];

  // Local image asset paths (replace with your actual paths)
  static const List<String> allCourseImageAssets = [
    // 'assets/images/accounting.png',
    // 'assets/images/autodesk.png',
    // 'assets/images/hardware.png',
    // 'assets/images/multimedia.png',
    // 'assets/images/networking.png',
    // 'assets/images/office.png',
    // 'assets/images/programming.png',
    // 'assets/images/english.png',
    // 'assets/images/internship.png',
    // 'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
    'assets/images/other.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses Info"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: allCourseCategories.length,
        itemBuilder: (context, index) {
          return CourseCard(
            title: allCourseCategories[index],
            description: allCourseDescriptions[index],
            duration: allCourseDurations[index],
            imageUrl: allCourseImageAssets[index], // Use asset paths
          );
        },
      ),
    );
  }
}
