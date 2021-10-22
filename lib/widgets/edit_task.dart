import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/custom_icons.dart';
import '../models/date.dart';
import '../models/remider_time.dart';
import '../providers/task.dart';
import '../providers/tasks.dart';
import './genial_radio_button.dart';
import './genial_done_button.dart';
import './task_date_picker.dart';
import './genial_checkbox.dart';
import './reminder_time_picker.dart';

class EditTask extends StatefulWidget {
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _textController;
  late Date _selectedDate;
  late bool _isRepeated;
  late ReminderTime _reminderTime;
  Task? _editedTask;
  bool moreProperties = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _textController = TextEditingController();
      _selectedDate = Date.today();
      _isRepeated = false;
      _reminderTime = ReminderTime.off();

      final arguments = ModalRoute.of(context)!.settings.arguments;
      if (arguments != null) {
        if (arguments is Date) {
          _selectedDate = arguments;
        } else if (arguments is String) {
          final taskId = arguments;
          _editedTask =
              Provider.of<Tasks>(context, listen: false).findById(taskId);
          _textController.text = _editedTask!.content;
          _textController.selection = TextSelection(
              baseOffset: 0, extentOffset: _textController.text.length);
          _selectedDate = _editedTask!.date;
          _isRepeated = _editedTask!.isRepeated;
          _reminderTime = _editedTask!.reminderTime;
        }
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveData() {
    if (_textController.text.isEmpty) return;

    final id =
        (_editedTask == null) ? DateTime.now().toString() : _editedTask!.id;
    if (_isRepeated) {
      var completed = 0;
      var failed = 0;
      if (_editedTask != null && _editedTask!.isRepeated) {
        var rtask = _editedTask as RepeatedTask;
        completed = rtask.completedCount;
        failed = rtask.failedCount;
      }
      Provider.of<Tasks>(context, listen: false).updateTask(RepeatedTask(
        id: id,
        content: _textController.text,
        date: _selectedDate,
        reminderTime: _reminderTime,
        completedCount: completed,
        failedCount: failed,
      ));
    } else {
      Provider.of<Tasks>(context, listen: false).updateTask(Task(
          id: id,
          content: _textController.text,
          date: _selectedDate,
          reminderTime: _reminderTime));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 70,
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SizedBox(width: 20),
              Flexible(
                child: TextField(
                  autofocus: true,
                  controller: _textController,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What do you want to do?',
                  ),
                  style: Theme.of(context).textTheme.headline2,
                  onSubmitted: (_) => _saveData(),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 40,
                child: IconButton(
                  icon: Icon(
                    CustomIcons.sliders_horizontal,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      moreProperties = !moreProperties;
                    });
                  },
                ),
              ),
              SizedBox(width: 10)
            ],
          ),
        ),
        if (moreProperties)
          Container(
            color: Color(0xFFF2F4F6),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenialCheckbox(
                      label: 'Everyday:',
                      icon: CustomIcons.arrows_cw,
                      value: _isRepeated,
                      backgroundColor: Color(0xFFF2F4F6),
                      onChecked: () {
                        setState(() {
                          _isRepeated = !_isRepeated;
                        });
                      }),
                  GenialCheckbox(
                      label: 'Notification:',
                      icon: CustomIcons.bell,
                      alterIcon: CustomIcons.bell_alt,
                      value: _reminderTime.enable,
                      backgroundColor: Color(0xFFF2F4F6),
                      onChecked: () {
                        showDialog(
                                context: context,
                                routeSettings:
                                    RouteSettings(arguments: _reminderTime),
                                builder: (ctx) => ReminderTimePicker())
                            .then((result) {
                          if (result != null) {
                            setState(() {
                              _reminderTime = result as ReminderTime;
                            });
                          }
                        });
                      }),
                ],
              ),
            ),
          ),
        Container(
          color: Color(0xFFF2F4F6),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                GenialRadioButton(
                    label: 'Today',
                    value: _selectedDate.isToday(),
                    onPressed: () {
                      if (!_selectedDate.isToday())
                        setState(() {
                          _selectedDate = Date.today();
                        });
                    }),
                GenialRadioButton(
                    label: 'Tomorrow',
                    value: _selectedDate.isTomorrow(),
                    onPressed: () {
                      if (!_selectedDate.isTomorrow())
                        setState(() {
                          _selectedDate = Date.tomorrow();
                        });
                    }),
                GenialRadioButton(
                    label: _selectedDate.isFuture()
                        ? _selectedDate.toString()
                        : 'Date',
                    value: _selectedDate.isFuture(),
                    onPressed: () {
                      showDialog(
                          context: context,
                          routeSettings: (_editedTask != null &&
                                  _editedTask!.date.isFuture())
                              ? RouteSettings(arguments: _editedTask!.date)
                              : null,
                          builder: (ctx) => TaskDatePicker()).then((result) {
                        if (result != null) {
                          setState(() {
                            _selectedDate = result as Date;
                          });
                        }
                      });
                    }),
                Spacer(),
                GenialDoneButton(onPressed: _saveData),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
