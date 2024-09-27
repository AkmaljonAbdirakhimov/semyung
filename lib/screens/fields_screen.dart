import 'package:flutter/material.dart';
import 'package:semyung/providers/field_provider.dart';
import 'package:semyung/screens/add_field_screen.dart';

class FieldsScreen extends StatefulWidget {
  const FieldsScreen({super.key});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  bool newFieldAdded = false;

  @override
  Widget build(BuildContext context) {
    final fields = FieldProvider.fields;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, newFieldAdded);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 35,
          ),
        ),
        title: const Text(
          "MAYDONLAR",
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // maydon qo'shish sahifasiga o'tish
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const AddFieldScreen();
              }));

              if (result != null) {
                // oynani yangilash
                newFieldAdded = true;
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: fields.length,
        itemBuilder: (context, index) {
          final field = fields[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: field.image.startsWith("http")
                  ? NetworkImage(
                      field.image,
                    )
                  : AssetImage(field.image),
            ),
            title: Text(field.title),
          );
        },
      ),
    );
  }
}
