import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/date.dart';

class TaskDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedDate = Date.dayAfterTomorrow();
    Date initDate = Date.dayAfterTomorrow();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      initDate = arguments as Date;
    }

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
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initDate.datetime,
                  minimumDate: Date.today().datetime,
                  minimumYear: DateTime.now().year,
                  maximumYear: DateTime.now().year + 5,
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedDate = Date.fromDateTime(newDateTime);
                  },
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
                      Navigator.of(context).pop();
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
                      Navigator.of(context).pop(selectedDate);
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
