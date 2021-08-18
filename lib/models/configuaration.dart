import 'package:flutter/material.dart';

import '../models/remider_time.dart';

enum AddDirection {
  Top,
  Bottom,
}

class Config {
  static const PRIMARY_GRADIENT = [Color(0xFFFF64A5), Color(0xFFFF8861)];

  static var reminderEveryday = ReminderTime.off();
  static var addingDirection = AddDirection.Bottom;

  static late final tasksListData;
}
