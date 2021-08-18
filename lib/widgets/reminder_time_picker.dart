import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/remider_time.dart';

class ReminderTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedTime = ReminderTime.now();
    final argument = ModalRoute.of(context)!.settings.arguments;
    if (argument != null && (argument as ReminderTime).enable)
      selectedTime = argument;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          padding: const EdgeInsets.only(top: 25, bottom: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 300,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                      1969, 1, 1, selectedTime.hour, selectedTime.minute),
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedTime = ReminderTime.fromTimeOfDay(
                        TimeOfDay.fromDateTime(newDateTime));
                  },
                  use24hFormat: true,
                  minuteInterval: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 18),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(ReminderTime.off());
                    },
                  ),
                  TextButton(
                    child: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 18),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(selectedTime);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
