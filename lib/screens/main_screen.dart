import 'package:flutter/material.dart';
import 'package:genialtask_clone/models/date.dart';
import 'package:provider/provider.dart';

import '../models/configuaration.dart';
import '../providers/tasks.dart';
import '../widgets/menu_update.dart';
import '../widgets/task_item.dart';
import '../widgets/edit_task.dart';
import '../widgets/genial_appbar_tab.dart';
import './sort_tasks_screen.dart';
import './more_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _tabController;
  var _currentTab = 0;
  var finishedTask = 0;

  @override
  void initState() {
    _tabController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todayTasks = Provider.of<Tasks>(context).todayTasks;
    final tomorrowTasks = Provider.of<Tasks>(context).tomorrowTasks;
    final futureTasks = Provider.of<Tasks>(context).futureTasks;

    void switchToTab(int newTab) {
      if (_currentTab != newTab) {
        _tabController.jumpToPage(newTab);
        setState(() {
          _currentTab = newTab;
        });
      }
    }

    void updateTasksHandler(String taskId) {
      showDialog(context: context, builder: (ctx) => MenuUpdate())
          .then((value) {
        switch (value) {
          case 1: //Edit
            showModalBottomSheet(
              context: context,
              routeSettings: RouteSettings(arguments: taskId),
              builder: (_) => EditTask(),
            );
            break;
          case 2: //Sort
            Navigator.of(context)
                .pushNamed(SortTasksScreen.routeName, arguments: _currentTab);
            break;
          case 3: //Delete
            Provider.of<Tasks>(context, listen: false).deleteTask(taskId);
            break;
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          flexibleSpace: Row(
            children: [
              GenialAppBarTab(
                label: 'Today',
                isSelected: _currentTab == 0,
                onPressed: () => switchToTab(0),
              ),
              GenialAppBarTab(
                label: 'Tomorrow',
                isSelected: _currentTab == 1,
                onPressed: () => switchToTab(1),
              ),
              GenialAppBarTab(
                label: 'Date',
                isSelected: _currentTab == 2,
                onPressed: () => switchToTab(2),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 18),
              child: MaterialButton(
                child: Icon(
                  Icons.more_horiz,
                  size: 24,
                  color: Colors.white,
                ),
                shape: CircleBorder(),
                hoverColor: Colors.white.withOpacity(0.05),
                splashColor: Colors.white.withOpacity(0.08),
                highlightColor: Colors.white.withOpacity(0.05),
                onPressed: () {
                  Navigator.of(context).pushNamed(MoreScreen.routeName);
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Ink(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: Config.PRIMARY_GRADIENT)),
            child: Icon(Icons.add, color: Colors.white),
          ),
          elevation: 0,
          splashColor: Colors.white10,
          focusColor: Colors.transparent,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                routeSettings: RouteSettings(
                    arguments: _currentTab == 1 ? Date.tomorrow() : null),
                builder: (_) {
                  return EditTask();
                });
          },
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: _tabController,
          onPageChanged: (tab) => switchToTab(tab),
          children: [
            todayTasks.isEmpty
                ? Center(
                    child: Text(
                      'You do not have any\ntasks today',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                        itemCount: todayTasks.length,
                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                              value: todayTasks[i],
                              child: TaskItem(() {
                                updateTasksHandler(todayTasks[i].id);
                              }),
                            )),
                  ),
            tomorrowTasks.isEmpty
                ? Center(
                    child: Text(
                      'You do not have any\ntasks tomorrow',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                        itemCount: tomorrowTasks.length,
                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                              value: tomorrowTasks[i],
                              child: TaskItem(() {
                                updateTasksHandler(tomorrowTasks[i].id);
                              }),
                            )),
                  ),
            futureTasks.isEmpty
                ? Center(
                    child: Text(
                      'You do not have any\ntasks in the future',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                        itemCount: futureTasks.length,
                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                              value: futureTasks[i],
                              child: TaskItem(() {
                                updateTasksHandler(futureTasks[i].id);
                              }),
                            )),
                  ),
          ],
        ));
  }
}
