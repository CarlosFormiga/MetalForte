import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/extensions/int_ext.dart';

extension TimeOfDayExt on TimeOfDay {
  String get time => '${hour.toTime()}:${minute.toTime()}';
  Duration toDuration() => Duration(hours: hour, minutes: minute);
}
