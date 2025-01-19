class Task2 {
  final String title;
  final String description;
  final String date;
  final String status; // e.g., "To-do", "Doing", "Done"
  final dynamic icon; // Use IconData or String for icons.

  Task2({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.icon,
  });
}



class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  // Factory constructor to parse JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }
}