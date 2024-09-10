import 'package:flutter/material.dart';
import 'package:semyung/screens/field_details_screen.dart';
import '../providers/field_provider.dart';
import '../models/field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FieldProvider fieldProvider = FieldProvider();
    List<Field> fields = fieldProvider.fields;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("SEMYUNG"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: fields.length,
        itemBuilder: (context, index) {
          Field field = fields[index];
          return InkWell(
            onTap: () {
              // maydon ma'lumotlar sahifasiga o'tishimiz kerak
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FieldDetailsScreen(field: field);
              }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  field.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(field.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Bosh Sahifa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
