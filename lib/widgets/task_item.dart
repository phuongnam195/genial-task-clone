import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/custom_icons.dart';
import '../models/date.dart';
import '../providers/task.dart';

class TaskItem extends StatefulWidget {
  final Function onLongPressed;

  TaskItem(this.onLongPressed);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final task = Provider.of<Task>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            activeColor: Theme.of(context).colorScheme.secondary,
            value: task.isCompleted,
            onChanged: (value) {
              task.toggleCompleted();
            },
          ),
          SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onLongPress: () => widget.onLongPressed(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.content,
                      textAlign: TextAlign.justify,
                      style: task.isCompleted
                          ? Theme.of(context).textTheme.headline3
                          : Theme.of(context).textTheme.headline2,
                    ),
                    if (task.date.isFuture())
                      Text('${task.date.difference(Date.today())} days left',
                          style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
              ),
            ),
          ),
          if (task.isRepeated)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                CustomIcons.arrows_cw,
                color: Color(0xFFC4C6CA),
                size: 19,
              ),
            ),
          if (task.reminderTime.enable)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                CustomIcons.bell,
                color: Color(0xFFC4C6CA),
                size: 19,
              ),
            ),
        ],
      ),
    );
  }
}
