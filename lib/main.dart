import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/configuaration.dart';
import './models/storage.dart';
import './providers/tasks.dart';
import './screens/main_screen.dart';
import './screens/welcome_screen.dart';
import './screens/sort_tasks_screen.dart';
import './screens/more_screen.dart';
import './screens/statistics_screen.dart';
import './screens/failed_tasks_screen.dart';
import './screens/completed_tasks_screen.dart';
import './screens/settings_screen.dart';
import './screens/about_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Storage.loadAsset('assets/data/tasks_list.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ChangeNotifierProvider<Tasks>(
              create: (ctx) => Tasks.fromJsonString(Config.tasksListData),
              child: MaterialApp(
                title: 'GenialTask',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: Color(0xFF392F42),
                  accentColor: Color(0xFFFF6B94),
                  hintColor: Color(0xFF7E8EAA),
                  fontFamily: 'Mulish',
                  textTheme: ThemeData.light().textTheme.copyWith(
                      headline1: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      headline2: TextStyle(
                        color: Color(0xFF392F42),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      headline3: TextStyle(
                        color: Color(0xFFFF6B94),
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w600,
                      ),
                      headline4: TextStyle(
                          color: Color(0xFF392F42),
                          fontSize: 19,
                          fontWeight: FontWeight.w800),
                      bodyText1: TextStyle(
                        color: Color(0xFF392F42),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle1: TextStyle(
                          color: Color(0xFF8493AE),
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
                initialRoute: MainScreen.routeName,
                // initialRoute: WelcomeScreen.routeName,
                routes: {
                  MainScreen.routeName: (ctx) => MainScreen(),
                  WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
                  SortTasksScreen.routeName: (ctx) => SortTasksScreen(),
                  MoreScreen.routeName: (ctx) => MoreScreen(),
                  StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
                  FailedTasksScreen.routeName: (ctx) => FailedTasksScreen(),
                  CompletedTasksScreen.routeName: (ctx) =>
                      CompletedTasksScreen(),
                  SettingsScreen.routeName: (ctx) => SettingsScreen(),
                  AboutScreen.routeName: (ctx) => AboutScreen(),
                },
              ),
            );
          return Container(
            child: Center(
                child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            )),
          );
        });
  }
}
