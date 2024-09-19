import 'package:flutter/material.dart';

import '../models/booking.dart';
import '../models/field.dart';
import 'field_provider.dart';

class BookingsProvider {
  static final List<Field> fields = FieldProvider.fields;

  static List<Booking> bookings = [];

  // boshlab olish va boshlang'ich buyurtmalarni e'lon qilish
  static void init() {
    bookings = [
      Booking(
        id: "booking1",
        field: fields[0], // stadion
        date: DateTime.now(),
        time: TimeOfDay.now(),
        faculty: "Computer Science",
        phone: "+998 90 000 00 00",
      ),
      Booking(
        id: "booking2",
        field: fields[0], // stadion
        date: DateTime.now(),
        time: TimeOfDay.now(),
        faculty: "Business Faculty",
        phone: "+998 90 000 00 01",
      ),
      Booking(
        id: "booking3",
        field: fields[1], // basketball
        date: DateTime.now(),
        time: TimeOfDay.now(),
        faculty: "Computer Science",
        phone: "+998 90 000 00 02",
      ),
      Booking(
        id: "booking4",
        field: fields[2], // tennis
        date: DateTime.now(),
        time: TimeOfDay.now(),
        faculty: "Business Faculty",
        phone: "+998 90 000 00 03",
      ),
    ];
  }

  // maydonga qarab buyurtmalarni filter qilamiz
  static List<Booking> getBookingsByField(Field field) {
    // agar buyurtmani maydonini ID'si teng bo'lsa bizlar so'ragan maydonni ID'siga
    // unda usha buyurtmalarni qaytarsin.
    return bookings.where((booking) {
      return booking.field.id == field.id;
    }).toList();
  }

  static void addBooking(Booking booking) {
    bookings.add(booking);
  }
}
