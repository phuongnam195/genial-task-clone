import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../widgets/genial_appbar.dart';

class CompletedTasksScreen extends StatelessWidget {
  static const routeName = '/more/completed-tasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenialAppBar(title: 'Completed tasks'),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.sentiment_satisfied_alt,
                color: Colors.black,
                size: 35,
              ),
              SizedBox(width: 10),
              Text(
                'Your completed tasks',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
              Consumer<Tasks>(
                builder: (_, tasksContainer, child) => Text(
                  tasksContainer.completedTasks.length.toString(),
                  style: TextStyle(
                      color: Theme.of(context).hintColor, fontSize: 16),
                ),
              ),
            ],
          ),
        )));
  }
}
