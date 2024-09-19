import 'package:flutter/material.dart';

import '../models/field.dart';

class FieldProvider {
  static final List<Field> fields = [
    Field(
      id: "1",
      title: "Stadion",
      image: "assets/images/stadium.jpg",
      startTime: const TimeOfDay(hour: 09, minute: 00),
      endTime: const TimeOfDay(hour: 18, minute: 00),
    ),
    Field(
      id: "2",
      title: "Basketbol Maydon",
      image: "assets/images/basketball.jpg",
      startTime: const TimeOfDay(hour: 10, minute: 00),
      endTime: const TimeOfDay(hour: 19, minute: 00),
    ),
    Field(
      id: "3",
      title: "Tennis maydon",
      image: "assets/images/tennis.jpg",
      startTime: const TimeOfDay(hour: 08, minute: 00),
      endTime: const TimeOfDay(hour: 17, minute: 00),
    ),
  ];
}
