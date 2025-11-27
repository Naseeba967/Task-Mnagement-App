import 'dart:convert';

/// Task model class representing a single task item.
/// Contains id, title, and completion status.
class Task {
  final String id;
  String title;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  /// Converts Task object to a Map for JSON encoding.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  /// Creates a Task object from a Map (JSON decoding).
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  /// Encodes a list of Task objects to a JSON string.
  static String encodeTaskList(List<Task> tasks) {
    final List<Map<String, dynamic>> jsonList =
        tasks.map((task) => task.toJson()).toList();
    return jsonEncode(jsonList);
  }

  /// Decodes a JSON string to a list of Task objects.
  static List<Task> decodeTaskList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList
        .map((json) => Task.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
