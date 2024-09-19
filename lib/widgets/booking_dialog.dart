import 'package:flutter/material.dart';

import '../providers/bookins_provider.dart';
import '../models/booking.dart';
import '../models/field.dart';

class BookingDialog extends StatefulWidget {
  final DateTime date;
  final Field field;
  const BookingDialog({
    super.key,
    required this.date,
    required this.field,
  });

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  final formKey = GlobalKey<FormState>();
  final timeController = TextEditingController();
  final facultyController = TextEditingController();
  final phoneController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  void addBooking() {
    // formani validatsiyasini tekshiramiz
    if (formKey.currentState!.validate()) {
      // buyurtma qo'shamiz
      final booking = Booking(
        id: UniqueKey().toString(),
        field: widget.field,
        date: widget.date,
        time: selectedTime,
        faculty: facultyController.text,
        phone: phoneController.text,
      );
      BookingsProvider.addBooking(booking);

      // buyurtma qilish
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Buyurtma qilish"),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: timeController,
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );

                  if (time != null) {
                    setState(() {
                      selectedTime = time;
                      timeController.text =
                          "${selectedTime.hour}:${selectedTime.minute}";
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Boshlanish vaqtini tanlang",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos vaqtni tanlang";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: facultyController,
                decoration: const InputDecoration(
                  labelText: "Fakultet",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos fakultet kiriting";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Telefon raqam",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos telefon raqam kiriting";
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            // Bekor qilish
            Navigator.pop(context, false);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Bekor Qilish"),
        ),
        FilledButton(
          onPressed: addBooking,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text("Buyurtma qilish"),
        ),
      ],
    );
  }
}
