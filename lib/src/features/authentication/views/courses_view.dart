import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:itc_app/service/course_service.dart';
import 'package:itc_app/src/features/authentication/models/data_model.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  CoursesViewState createState() => CoursesViewState();
}

class CoursesViewState extends State<CoursesView> {
  late Future<List<Course>> _coursesFuture;
  final CourseService _courseService = CourseService();

  @override
  void initState() {
    super.initState();
    _coursesFuture = _courseService.fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Catalog"),
      ),
      body: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Course> courses = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showCourseDetails(context, courses[index]);
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: courses[index].imageUrl.isNotEmpty
                              ? Image.asset(
                                  courses[index].imageUrl,
                                  fit: BoxFit.contain,
                                )
                              : const Placeholder(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            courses[index].title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  void _showCourseDetails(BuildContext context, Course course) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded( // Added Expanded here
              child: Text(
                course.title,
                overflow: TextOverflow.ellipsis, // Added overflow
                maxLines: 2, // Added max lines
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white70,
                Colors.white,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Material(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: course.description
                        .split(',')
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• '),
                                Expanded( // Added Expanded here
                                  child: Text(
                                    item.trim(),
                                    overflow: TextOverflow.ellipsis, // Added overflow
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: const <Widget>[],
      );
    },
  );
}
}

// import 'package:flutter/material.dart';
// import 'package:itc_app/service/course_service.dart';
// import 'package:itc_app/src/features/authentication/models/data_model.dart';
// import 'package:itc_app/src/shared/ui/widgets/card_course.dart';

// class CoursesView extends StatefulWidget {
//   const CoursesView({super.key});

//   @override
//   CoursesViewState createState() => CoursesViewState();
// }

// class CoursesViewState extends State<CoursesView> {
//   late Future<List<Course>> _coursesFuture;
//   final CourseService _courseService = CourseService();

//   @override
//   void initState() {
//     super.initState();
//     _coursesFuture = _courseService.fetchCourses();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Courses Info"),
//       ),
//       body: FutureBuilder<List<Course>>(
//         future: _coursesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             List<Course> courses = snapshot.data!;
//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: courses.length,
//               itemBuilder: (context, index) {
//                 return CourseCard(
//                   title: courses[index].title,
//                   description: courses[index].description,
//                   imageUrl: courses[index].imageUrl,
//                   // duration: courses[index].duration,
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('No data available'));
//           }
//         },
//       ),
//     );
//   }
// }


//---------OLD CODE - WITHOUT API -----------
// import 'package:flutter/material.dart';
// import 'package:itc_app/src/shared/ui/widgets/card_course.dart';

// class CoursesView extends StatelessWidget {
//   const CoursesView({super.key});

//   // Course categories
//   static const List<String> allCourseCategories = [
//     'Accounting',
//     'Artificial Intelligence',
//     'Autodesk',
//     'Ethical Hacking',
//     'Hardware',
//     'Multimedia',
//     'Cloud Computing & Networking',
//     'Data Analysis & Office Automation',
//     'Programming',
//     'Spoken English',
//     'Internship',
//     'Other'
//   ];

//   // Course descriptions
//   static const List<String> allCourseDescriptions = [
//   'Learn accounting principles, financial analysis, and budgeting. Build a foundation for a finance career.',
//   'Implement AI solutions, automate tasks, and optimize processes. Drive efficiency with intelligent technology.',
//   'Master Autodesk software for 2D/3D modeling in architecture and engineering. Prepare for industry certifications.',
//   'Study cryptography, network protocols, and ethical hacking methodologies. Become a guardian of data integrity.',
//   'Gain hardware knowledge: CPUs, motherboards, memory. Learn to assemble and repair systems for IT careers.',
//   'Unleash your creativity through the power of multimedia. Develop your skills in graphics and video editing.',
//   'Learn networking concepts, security, and administration. Configure routers and switches for network careers.',
//   'Master Microsoft Office Suite for document creation, data analysis, and presentations in office environments.',
//   'Learn programming languages like Python and Java. Develop skills in software and app development.',
//   'Improve spoken English: pronunciation, grammar, vocabulary. Practice for presentations and interviews.',
//   'Gain practical experience through internships. Apply skills in real-world settings and build your network.',
//   'Explore specialized courses like data science and web development. Learn emerging technologies.',
// ];

//   // // Course durations
//   // static const List<String> allCourseDurations = [
//   //   '3 Months | 1 Month (Vacation)',
//   //   '1 Month (Vacation) ',
//   //   '4 Months',
//   //   '1 Month (Vacation)',
//   //   '2 Months',
//   //   '3 Months',
//   //   '4 Months',
//   //   '2 Months',
//   //   '3 Months',
//   //   '2 Months',
//   //   'Variable',
//   //   'Variable',
//   // ];

//   // Local image asset paths (replace with your actual paths)
//   static const List<String> allCourseImageAssets = [
//     'assets/images/accounting.png',
//     'assets/images/artificial.webp',
//     'assets/images/autodesk.png',
//     'assets/images/ethical_hacking.jpg',
//     'assets/images/hardware.jpg',
//     'assets/images/multimedia.png',
//     'assets/images/networking.png',
//     'assets/images/data_analysis.png', 
//     'assets/images/programming.png',
//     'assets/images/spoken_english.png',
//     'assets/images/internship.jpg',
//     'assets/images/other.png',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Courses Info"),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemCount: allCourseCategories.length,
//         itemBuilder: (context, index) {
//           return CourseCard(
//             title: allCourseCategories[index],
//             description: allCourseDescriptions[index],
//             // duration: allCourseDurations[index],
//             imageUrl: allCourseImageAssets[index], // Use asset paths
//           );
//         },
//       ),
//     );
//   }
// }
