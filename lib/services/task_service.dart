import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

/// Service class for managing task data persistence using SharedPreferences.
/// Handles saving, loading, adding, updating, and deleting tasks.
class TaskService {
  static const String _tasksKey = 'tasks';

  /// Loads all tasks from SharedPreferences.
  /// Returns an empty list if no tasks are saved.
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString(_tasksKey);

    if (tasksJson == null || tasksJson.isEmpty) {
      return [];
    }

    try {
      return Task.decodeTaskList(tasksJson);
    } catch (e) {
      // If there's an error decoding, return empty list
      return [];
    }
  }

  /// Saves the list of tasks to SharedPreferences.
  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksJson = Task.encodeTaskList(tasks);
    return prefs.setString(_tasksKey, tasksJson);
  }

  /// Adds a new task and saves to SharedPreferences.
  Future<List<Task>> addTask(List<Task> currentTasks, String title) async {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );

    final updatedTasks = [...currentTasks, newTask];
    await saveTasks(updatedTasks);
    return updatedTasks;
  }

  /// Toggles the completion status of a task and saves.
  Future<List<Task>> toggleTaskCompletion(
      List<Task> currentTasks, String taskId) async {
    final updatedTasks = currentTasks.map((task) {
      if (task.id == taskId) {
        task.isCompleted = !task.isCompleted;
      }
      return task;
    }).toList();

    await saveTasks(updatedTasks);
    return updatedTasks;
  }

  /// Deletes a task by ID and saves the updated list.
  Future<List<Task>> deleteTask(List<Task> currentTasks, String taskId) async {
    final updatedTasks =
        currentTasks.where((task) => task.id != taskId).toList();
    await saveTasks(updatedTasks);
    return updatedTasks;
  }
}
