import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../widgets/genial_appbar.dart';

class FailedTasksScreen extends StatelessWidget {
  static const routeName = '/more/failed-tasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenialAppBar(title: 'Failed tasks'),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.sentiment_very_dissatisfied,
                color: Theme.of(context).accentColor,
                size: 35,
              ),
              SizedBox(width: 10),
              Text(
                'Your failed tasks',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
              Consumer<Tasks>(
                builder: (_, tasksContainer, child) => Text(
                  tasksContainer.failedTasks.length.toString(),
                  style: TextStyle(
                      color: Theme.of(context).hintColor, fontSize: 16),
                ),
              ),
            ],
          ),
        )));
  }
}
