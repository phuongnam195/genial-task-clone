import 'package:flutter/material.dart';
import 'package:genialtask_clone/widgets/genial_appbar.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart';
import '../providers/tasks.dart';

class SortTasksScreen extends StatefulWidget {
  static const routeName = '/sort-tasks';

  @override
  _SortTasksScreenState createState() => _SortTasksScreenState();
}

class _SortTasksScreenState extends State<SortTasksScreen> {
  late List<Task> _tasks;
  late final _sortedTab;
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    final tasksContainer = Provider.of<Tasks>(context, listen: false);

    if (!_isLoaded) {
      _sortedTab = ModalRoute.of(context)!.settings.arguments as int;

      if (_sortedTab == 0) {
        _tasks = tasksContainer.todayTasks;
      } else if (_sortedTab == 1) {
        _tasks = tasksContainer.tomorrowTasks;
      }

      _isLoaded = true;
    }

    return Scaffold(
      appBar: GenialAppBar(
        title: 'Sort',
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              if (_sortedTab == 0)
                tasksContainer.deleteTodayTasks();
              else if (_sortedTab == 1) tasksContainer.deleteTomorrowTasks();
              tasksContainer.addTasks(_tasks);
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        children: [
          for (int i = 0; i < _tasks.length; i++)
            Row(
              key: Key('$i'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      _tasks[i].content,
                      textAlign: TextAlign.justify,
                      style: _tasks[i].isCompleted
                          ? Theme.of(context).textTheme.headline3
                          : Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                ReorderableDragStartListener(
                  index: i,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.drag_handle,
                      color: Color(0xFFB9C2D1),
                    ),
                  ),
                ),
              ],
            )
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final task = _tasks.removeAt(oldIndex);
            _tasks.insert(newIndex, task);
          });
        },
      ),
    );
  }
}
