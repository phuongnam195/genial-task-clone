import 'package:flutter/material.dart';

import '../models/configuaration.dart';
import '../widgets/menu_adding_direction.dart';
import '../widgets/genial_appbar.dart';
import '../widgets/reminder_time_picker.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/more/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Widget settingItem(String title, String value, Function onPressed,
        {String? subtitle}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: () => onPressed(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: (subtitle != null ? 10 : 15), horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 19)),
                      )
                  ],
                ),
                Text(
                  value,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: GenialAppBar(title: 'Settings'),
        body: Container(
            child: Column(
          children: [
            SizedBox(height: 10),
            settingItem('Task reminder', Config.reminderEveryday.format(), () {
              showDialog(
                  context: context,
                  routeSettings:
                      RouteSettings(arguments: Config.reminderEveryday),
                  builder: (ctx) => ReminderTimePicker()).then((result) {
                if (result != null) {
                  setState(() {
                    Config.reminderEveryday = result;
                  });
                }
              });
            },
                subtitle:
                    'Show notification if there are any\nunfinished tasks'),
            settingItem('Adding new tasks',
                Config.addingDirection == AddDirection.Top ? 'Top' : 'Bottom',
                () {
              showDialog(
                  context: context,
                  builder: (ctx) => MenuAddingDirection()).then((result) {
                if (result != null) {
                  setState(() {
                    Config.addingDirection = result;
                  });
                }
              });
            })
          ],
        )));
  }
}
