import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:itc_app/src/features/authentication/functions/form_helpers.dart';
// import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GuestInquiryForm extends StatefulWidget {
  const GuestInquiryForm({super.key});

  @override
  State<GuestInquiryForm> createState() => _GuestInquiryFormState();
}

class _GuestInquiryFormState extends State<GuestInquiryForm> {
  final _formKey = GlobalKey<FormState>();

  String fName = '';
  String lName = '';
  String fullName = '';
  String gender = 'Male';
  String mobile = '';
  String email = '';
  String knowITCFrom = '';
  String inquiryDate = '';
  List<String> interestedCoursesCategory = [];

  static const List<String> knowITCSources = [
    'Advertisement',
    'Appication',
    'Facebook',
    'Friend/Relative',
    'Handbill',
    'Hoarding Board',
    'Instagram',
    'ITC website',
    'JustDial',
    'kiosk',
    'On Premise',
    'Past Student',
    'ITC Banner',
    'Seminar',
    'SMS',
    'Whatsapp',
    'Other'
  ];

  // Regular course categories
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

  // Vacation Course Categories
static const List<String> vacationCourseCategories = [
  '2D, 3D Engineering',
  // '2D, 3D Engineering (CAD/CAM)',
  'Accounting',
  'Artificial Intelligence',
  'Cloud Computing & Networking',
  'Cyber Security and Ethical Hacking',
  'Data Analytics & Office Automation',
  'IoT, Robotics & Hardware Repairing',
  'Multimedia & AR/VR',
  // 'Multimedia & AR/VR (Graphics & Animation)',
  'Programming',
  'Spoken English',
];

  Future<void> _submitForm() async {
  bool formIsValid = _formKey.currentState!.validate();
  bool courseCategoryIsValid = validateCourseCategory(interestedCoursesCategory) == null;

  // if (formIsValid && courseCategoryIsValid) {
  //   inquiryDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  if (formIsValid && courseCategoryIsValid) {
    // Use ISO 8601 format
    inquiryDate = DateTime.now().toIso8601String();

    // Or, if needed, try SQL Server specific format
    // inquiryDate = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.now().toUtc());


    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/submitInquiry'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fName': fName,
          'lName': lName,
          'gender': gender,
          'mobile': mobile,
          'email': email,
          'knowITCFrom': knowITCFrom,
          'inquiryDate': inquiryDate,
          'interestedCoursesCategory': interestedCoursesCategory,
        }),
      );

      if (mounted) {
        final localContext = context; // Store BuildContext locally.

        if (response.statusCode == 200) {
          final decodedResponse = jsonDecode(response.body);

          if (decodedResponse['status'] == 'success') {
            _formKey.currentState!.reset();
            interestedCoursesCategory = [];
            if (localContext.mounted) {
              ScaffoldMessenger.of(localContext).showSnackBar(
                const SnackBar(content: Text('Inquiry Submitted Successfully!')),
              );
            }
          } else {
            if (localContext.mounted) {
              ScaffoldMessenger.of(localContext).showSnackBar(
                SnackBar(content: Text(decodedResponse['message'])),
              );
            }
          }
        } else {
          if (localContext.mounted) {
            ScaffoldMessenger.of(localContext).showSnackBar(
              const SnackBar(content: Text('Error submitting inquiry.')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        final localContext = context;
        if (localContext.mounted) {
          ScaffoldMessenger.of(localContext).showSnackBar(
            SnackBar(content: Text('An error occurred: $e')),
          );
        }
      }
    }
  } else {
    setState(() {});
  }
}

// Gender Validation Function
// String? _validateGender(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Select a Gender';
//   }
//   return null;
// }

// // Checkbox Validation Function - Course Category
//   String? validateCourseCategory(List<String>? value) {
//     if (value == null || value.isEmpty) {
//       return 'Select at Least One Course Category';
//     }
//     if (value.length > 2) {
//     return 'Maximum 2 courses allowed';
//     }
//     return null;
//   }

// State variables and functions
String courseType = 'regular'; // Default course type
List<String> displayedCourses = allCourseCategories; // Initial courses
String? formError;

void fetchCourses(String type) {
  setState(() {
    interestedCoursesCategory.clear(); //Clear previously selected courses.
    if (type == 'regular') {
      displayedCourses = allCourseCategories; // Load regular courses
      // In real scenario, you'd fetch regular courses from a service.
    } else if (type == 'vacation') {
      displayedCourses = vacationCourseCategories; // Load vacation courses
      // In real scenario, you'd fetch vacation courses from a service.
    }
  });
}

String? validateCourseCategory(List<String>? value) {
  if (value == null || value.isEmpty) {
    setState(() {
      formError = "Please select at least one course category";
    });
    return "Please select at least one course category";
  }
  setState(() {
    formError = null;
  });
  return null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("INQUIRY FORM")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Container( // Wrap the form with a Container for styling
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
                color: Colors.cyanAccent.withValues(),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              //First Name
                              Expanded(
                                child: buildTextField("First Name", (value) => fName = value,
                                (value) => value == null || value.isEmpty ? 'Enter First Name' : null),
                              ),
                              const SizedBox(width: 8),
                              //Last Name
                              Expanded(
                                child: buildTextField("Last Name", (value) => lName = value,
                                (value) => value == null || value.isEmpty ? 'Enter last Name' : null),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Gender
                              Expanded(
                                flex: 2,
                                child: FormField<String>(
                                  // Gender Radio Buttons
                                  builder: (FormFieldState<String> state) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                          child: buildRadioButtons(
                                            "Gender",
                                            ['Male', 'Female'],
                                            (value) {
                                              setState(() {
                                                gender = value;
                                                state.didChange(value);
                                              });
                                            },
                                            gender, // Use the state variable
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  // validator: _validateGender,
                                ),
                              ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      // Mobile Number
                      child: buildTextField("Mobile Number", (value) => mobile = value, (value) {
                          if (value == null || value.isEmpty) return 'Enter Mobile Number';
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return 'Invalid mobile number';
                          return null;
                          }, keyboardType: TextInputType.phone),
                        ),
                      ],
                    ),
                    // Email Id
                    buildTextField("Email Id", (value) => email = value, (value) {
                      if (value == null || value.isEmpty) return 'Enter E-Mail Id';
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Invalid email';
                      return null;
                    }, keyboardType: TextInputType.emailAddress),
                    //Know ITC From
                    Row(
                    children: [
                      // Sources
                      Expanded(
                        flex: 1,
                        child: buildDropdown("Know ITC From?", knowITCSources,
                        (value) => knowITCFrom = value ?? '',
                        (value) => value == null ? 'Select From Where You Got Know About ITC' : null),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Course Type", style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: Radio<String>(
                                value: 'regular',
                                groupValue: courseType,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      courseType = value;
                                      fetchCourses(courseType); // Fetch courses based on type
                                    });
                                  }
                                },
                              ),
                            ),
                            const Text('Regular'),
                            Radio<String>(
                              value: 'vacation',
                              groupValue: courseType,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    courseType = value;
                                    fetchCourses(courseType); // Fetch courses based on type
                                  });
                                }
                              },
                            ),
                            const Text('Vacation'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("Course Category", style: TextStyle(fontWeight: FontWeight.bold)),
                        Wrap(
                          spacing: -18.0,
                          runSpacing: -6.0,
                          children: displayedCourses.map((course) {
                            return SizedBox(
                              key: ValueKey(course),
                              width: MediaQuery.of(context).size.width / 2.16 - 1,
                              child: CheckboxListTile(
                                title: Text(course),
                                value: interestedCoursesCategory.contains(course),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      if (value) {
                                        interestedCoursesCategory.add(course);
                                        } else {
                                          interestedCoursesCategory.remove(course);
                                        }
                                      });
                                    }
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          if (formError != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: Text(
                              formError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: Colors.green),
                          ),
                        ),
                        icon: const Icon(
                          Icons.check_circle, // Or any other suitable icon
                          color: Colors.green,
                          size: 20,
                        ),
                        label: const Text("SUBMIT"),
                      ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}
