import './providers/task.dart';
import './providers/tasks.dart';
import './models/date.dart';
import './models/remider_time.dart';

class DummyData {
  static void generate() {
    print(dummyTasksData.toJsonString());
  }

  static final Tasks dummyTasksData = Tasks([
    Task(
        id: '001',
        content: 'Chơi game',
        date: Date.today(),
        reminderTime: ReminderTime(16, 30)),
    Task(id: '002', content: 'Đi ngủ', date: Date(14, 8, 2021)),
    RepeatedTask(id: '003', content: 'Học tiếng Anh', date: Date(13, 8, 2021)),
    RepeatedTask(
        id: '004',
        content:
            'Đây là nhiệm vụ dài nhất thế kỉ, không thể dài hơn, vì đây là cái dài nhất. Nếu bạn vẫn không tin đây là nhiệm vụ dài nhất thì hãy thử tìm nhiệm vụ dài hơn. Bạn sẽ phải chấp nhận.',
        date: Date.tomorrow(),
        reminderTime: ReminderTime(21, 0)),
    RepeatedTask(
        id: '005',
        content: 'Dắt mèo đi dạo',
        date: Date(10, 8, 2021),
        isCompleted: true,
        completedCount: 2,
        failedCount: 1),
    RepeatedTask(
        id: '006',
        content: 'Giặt áo quần',
        date: Date.dayAfterTomorrow(),
        reminderTime: ReminderTime(5, 30)),
    Task(id: '007', content: 'Thi cử', date: Date(20, 8, 2021)),
    Task(
        id: '008',
        content: 'Ôn bài',
        date: Date(24, 8, 2021),
        reminderTime: ReminderTime(19, 40)),
  ]);
}
