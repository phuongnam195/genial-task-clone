import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../widgets/genial_appbar.dart';
import './completed_tasks_screen.dart';
import './failed_tasks_screen.dart';

class StatisticsScreen extends StatelessWidget {
  static const routeName = '/more/statistics';

  @override
  Widget build(BuildContext context) {
    final tasksContainer = Provider.of<Tasks>(context);

    Widget statItem(IconData icon, String title, String subtitle, Color color,
        String routeNameTapped) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Color(0xFFF2F4F6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 35,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: TextStyle(
                          color: color,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.east,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(routeNameTapped);
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        appBar: GenialAppBar(title: 'Statistics'),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                tasksContainer.tasks.length.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12),
              Text(
                'Tasks created',
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              statItem(
                  Icons.sentiment_satisfied_alt,
                  tasksContainer.completedTasks.length.toString(),
                  'success',
                  Colors.black,
                  CompletedTasksScreen.routeName),
              SizedBox(height: 10),
              statItem(
                  Icons.sentiment_very_dissatisfied,
                  tasksContainer.failedTasks.length.toString(),
                  'failed',
                  Theme.of(context).colorScheme.secondary,
                  FailedTasksScreen.routeName),
            ],
          ),
        ));
  }
}
