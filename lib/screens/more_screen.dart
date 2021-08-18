import 'package:flutter/material.dart';

import './failed_tasks_screen.dart';
import './statistics_screen.dart';
import './settings_screen.dart';
import './about_screen.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = '/more';

  @override
  Widget build(BuildContext context) {
    Widget textButton(String content, Function onPressed) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TextButton(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              content,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800),
            ),
          ),
          style: TextButton.styleFrom(
            shadowColor: Colors.transparent,
            primary: Colors.white12,
            elevation: 0,
          ),
          onPressed: () => onPressed(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textButton('Failed tasks', () {
                    Navigator.pushNamed(context, FailedTasksScreen.routeName);
                  }),
                  textButton('Statistics', () {
                    Navigator.pushNamed(context, StatisticsScreen.routeName);
                  }),
                  textButton('Settings', () {
                    Navigator.pushNamed(context, SettingsScreen.routeName);
                  }),
                  textButton('About', () {
                    Navigator.pushNamed(context, AboutScreen.routeName);
                  }),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
