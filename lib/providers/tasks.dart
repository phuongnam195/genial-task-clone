import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/date.dart';

import '../models/configuaration.dart';
import './task.dart';

class Tasks with ChangeNotifier {
  final List<Task> _tasks;

  Tasks(this._tasks);

  factory Tasks.fromJsonString(String data) {
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
    List<Task> tasks = parsed.map<Task>((json) {
      json as Map<String, dynamic>;
      if (json.containsKey('completedCount'))
        return RepeatedTask.fromJson(json);
      return Task.fromJson(json);
    }).toList();

    // Cần loại bỏ task cũ, cập nhật complete/uncomplete cho repeated tasks.
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].date.isPast()) {
        if (tasks[i].isRepeated == false) {
          tasks.removeAt(i);
        } else {
          Task task = tasks[i];
          task as RepeatedTask;
          var completed = task.completedCount;
          var failed = task.failedCount;

          // Nếu task có date là 14/8 (hiện tại là 17/8), mà task đã completed thì
          // ngày 14/8 nó completed, nhưng ngày 15, 16 nó failed (không mở app)
          if (task.isCompleted) {
            completed++;
          } else {
            failed++;
          }
          failed += (Date.today().difference(task.date) - 1);

          tasks[i] = RepeatedTask(
            id: task.id,
            content: task.content,
            date: Date.today(),
            completedCount: completed,
            failedCount: failed,
          );
        }
      }
    }

    return Tasks(tasks);
  }

  String toJsonString() => JsonEncoder.withIndent('\t').convert(_tasks);

  List<Task> get tasks {
    return [..._tasks];
  }

  List<Task> get todayTasks {
    return _tasks.where((task) => (task.date.isToday())).toList();
  }

  List<Task> get tomorrowTasks {
    return _tasks.where((task) => (task.date.isTomorrow())).toList();
  }

  List<Task> get futureTasks {
    return _tasks.where((task) => (task.date.isFuture())).toList();
  }

  List<Task> get completedTasks {
    return _tasks.where((task) => (task.isCompleted == true)).toList();
  }

  List<Task> get failedTasks {
    return _tasks
        .where((task) => (task.date.isPast() && task.isCompleted == false))
        .toList();
  }

  void addTasks(List<Task> newTasks) {
    if (Config.addingDirection == AddDirection.Top) {
      for (int i = newTasks.length - 1; i >= 0; i--) {
        _tasks.insert(0, newTasks[i]);
      }
    } else {
      newTasks.forEach((newTask) {
        _tasks.add(newTask);
      });
    }
    notifyListeners();
  }

  void updateTask(Task newTask) {
    final index = _tasks.indexWhere((task) => task.id == newTask.id);
    if (index >= 0) {
      _tasks[index] = newTask;
    } else {
      if (Config.addingDirection == AddDirection.Top)
        _tasks.insert(0, newTask);
      else
        _tasks.add(newTask);
    }
    notifyListeners();
  }

  Task findById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void deleteTodayTasks() {
    _tasks.removeWhere((task) => (task.date.isToday()));
    notifyListeners();
  }

  void deleteTomorrowTasks() {
    _tasks.removeWhere((task) => (task.date.isTomorrow()));
    notifyListeners();
  }
}
