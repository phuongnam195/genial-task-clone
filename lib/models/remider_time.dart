import 'package:flutter/material.dart';

class ReminderTime {
  final bool enable;
  final int hour;
  final int minute;

  ReminderTime(this.hour, this.minute, {this.enable = true});
  ReminderTime.fromTimeOfDay(TimeOfDay time)
      : this.enable = true,
        this.hour = time.hour,
        this.minute = time.minute;
  const ReminderTime.off()
      : enable = false,
        hour = -1,
        minute = -1;
  factory ReminderTime.fromJson(Map json) {
    if (json['enable'] == false) return ReminderTime.off();
    return ReminderTime(json['hour'], json['minute']);
  }

  Map toJson() => enable
      ? {'enable': enable, 'hour': hour, 'minute': minute}
      : {'enable': enable};

  static ReminderTime now() => ReminderTime.fromTimeOfDay(TimeOfDay.now());

  String format() {
    if (!enable) return 'Off';
    String result = '';
    if (hour < 10) result += '0';
    result = result + hour.toString() + ':';
    if (minute < 10) result += '0';
    result = result + minute.toString();
    return result;
  }
}
