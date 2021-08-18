import 'package:flutter/foundation.dart';
import '../models/remider_time.dart';

import '../models/date.dart';

class Task with ChangeNotifier {
  final String id;
  final String content;
  bool isCompleted;
  final Date date;
  final ReminderTime reminderTime;

  Task({
    required this.id,
    required this.content,
    this.isCompleted = false,
    required this.date,
    this.reminderTime = const ReminderTime.off(),
  });

  Task.fromJson(Map json)
      : id = json['id'],
        content = json['content'],
        isCompleted = json['isCompleted'],
        date = Date.fromJson(json['date']),
        reminderTime = ReminderTime.fromJson(json['reminderTime']);

  Map toJson() => {
        'id': id,
        'content': content,
        'isCompleted': isCompleted,
        'date': date.toJson(),
        'reminderTime': reminderTime.toJson(),
      };

  bool get isRepeated => false;

  void toggleCompleted() {
    isCompleted = !isCompleted;
    notifyListeners();
  }
}

class RepeatedTask extends Task {
  final int completedCount;
  final int failedCount;

  RepeatedTask({
    required String id,
    required String content,
    bool isCompleted = false,
    required Date date,
    ReminderTime reminderTime = const ReminderTime.off(),
    int completedCount = 0,
    int failedCount = 0,
  })  : this.completedCount = completedCount,
        this.failedCount = failedCount,
        super(
            id: id,
            content: content,
            isCompleted: isCompleted,
            date: date,
            reminderTime: reminderTime);

  RepeatedTask.fromJson(Map json)
      : completedCount = json['completedCount'],
        failedCount = json['failedCount'],
        super.fromJson(json);

  @override
  Map toJson() => {
        ...super.toJson(),
        ...{
          'completedCount': completedCount,
          'failedCount': failedCount,
        },
      };

  @override
  bool get isRepeated => true;
}
