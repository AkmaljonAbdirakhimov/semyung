import 'package:flutter/material.dart';
import 'package:semyung/models/field.dart';
import 'package:semyung/providers/field_provider.dart';

class AddFieldScreen extends StatefulWidget {
  const AddFieldScreen({super.key});

  @override
  State<AddFieldScreen> createState() => _AddFieldScreenState();
}

class _AddFieldScreenState extends State<AddFieldScreen> {
  final imageController = TextEditingController();
  final titleController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  // ? so'roq belgisi o'zgaruvchini bush bo'lishi mumkinligini anglatadi
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "MAYDON QO'SHISH",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                print("Rasm tanlash oynasi ochilsin");
                final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("RASM"),
                      content: TextField(
                        controller: imageController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Rasm URL kiriting",
                        ),
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            // pop funksiyasi - Hozirgi aktiv oynani yopib beradi
                            Navigator.pop(context, false);
                          },
                          child: const Text("BEKOR QILISH"),
                        ),
                        FilledButton(
                          onPressed: () {
                            // pop funksiyasi - Hozirgi aktiv oynani yopib beradi
                            Navigator.pop(context, true);
                          },
                          child: const Text("SAQLASH"),
                        ),
                      ],
                    );
                  },
                );

                print(result);
                if (result == true) {
                  setState(() {}); // oynani yangilaydi
                }
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.maxFinite,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: imageController.text.isEmpty
                    ? const Text("Rasm Tanlang")
                    : Image.network(
                        imageController.text,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nomini kiriting",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: startTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Ish boshlanish vaqtini kiriting",
              ),
              onTap: () async {
                final result = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (result != null) {
                  // ! undov belgisi bu o'zgaruvchi bush emasligini aytadi
                  startTimeController.text = "${result.hour}:${result.minute}";
                  startTime = result;
                }
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: endTimeController,
              readOnly: true,
              onTap: () async {
                final result = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (result != null) {
                  // ! undov belgisi bu o'zgaruvchi bush emasligini aytadi
                  endTimeController.text = "${result.hour}:${result.minute}";
                  endTime = result;
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Ish tugash vaqtini kiriting",
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                // maydonni saqlash
                final image = imageController.text;
                final title = titleController.text;

                if (image.isNotEmpty &&
                    title.isNotEmpty &&
                    startTime != null &&
                    endTime != null) {
                  final newField = Field(
                    id: UniqueKey().toString(),
                    title: title,
                    image: image,
                    startTime: startTime!,
                    endTime: endTime!,
                  );

                  FieldProvider.addField(newField);
                  Navigator.pop(context, true);
                }
              },
              child: const Text("SAQLASH"),
            ),
          ],
        ),
      ),
    );
  }
}
