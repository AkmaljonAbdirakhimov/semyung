import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/field.dart';
import '../models/booking.dart';
import '../widgets/booking_dialog.dart';
import '../providers/bookins_provider.dart';

class FieldDetailsScreen extends StatefulWidget {
  final Field field;
  const FieldDetailsScreen({
    super.key,
    required this.field,
  });

  @override
  State<FieldDetailsScreen> createState() => _FieldDetailsScreenState();
}

class _FieldDetailsScreenState extends State<FieldDetailsScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Booking> bookings = BookingsProvider.getBookingsByField(widget.field);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(widget.field.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.field.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            TableCalendar(
              calendarFormat: CalendarFormat.week,
              focusedDay: DateTime.now(),
              firstDay: DateTime(2020),
              lastDay: DateTime(3000),
              currentDay: selectedDate,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  selectedDate = selectedDay;
                });
              },
            ),
            const SizedBox(height: 20),
            for (Booking booking in bookings)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${formatTime(booking.time)}-${formatTime(TimeOfDay(hour: booking.time.hour + 1, minute: booking.time.minute))}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      booking.faculty,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FilledButton(
          onPressed: () async {
            // dialog ochishimiz kerak
            final result = await showDialog(
              context: context,
              builder: (context) {
                return BookingDialog(
                  date: selectedDate,
                  field: widget.field,
                );
              },
            );

            if (result == true) {
              setState(() {});
            }
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text("BUYURTMA QILISH"),
        ),
      ),
    );
  }

  String formatTime(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }
}
