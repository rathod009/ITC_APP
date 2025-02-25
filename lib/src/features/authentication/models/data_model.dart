class Course {
  final String title;
  final String description;
  final String imageUrl; // Or a URL
  // final String duration; // If you still want duration

  Course({
    required this.title,
    required this.description,
    required this.imageUrl,
    // this.duration,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      // duration: json['duration'],
    );
  }
}
