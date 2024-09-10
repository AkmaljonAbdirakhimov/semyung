import 'package:flutter/material.dart';

class Field {
  String id;
  String title;
  String image;
  TimeOfDay startTime;
  TimeOfDay endTime;

  // konstruktor - ya'ni maydon yaratilgan qaysi
  // ma'lumotlarni kiritib ketish kerakligi aytiladi
  Field({
    required this.id,
    required this.title,
    required this.image,
    required this.startTime,
    required this.endTime,
  });
}
