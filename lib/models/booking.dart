import 'package:flutter/material.dart';

import 'field.dart';

class Booking {
  final String id;
  final Field field;
  final DateTime date;
  final TimeOfDay time;
  final String faculty;
  final String phone;

  Booking({
    required this.id,
    required this.field,
    required this.date,
    required this.time,
    required this.faculty,
    required this.phone,
  });
}
