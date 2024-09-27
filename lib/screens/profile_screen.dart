import 'package:flutter/material.dart';
import 'package:semyung/screens/fields_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const Text("Alisher Niyozov"),
            ListTile(
              onTap: () async {
                // Maydonlar ro'yxati sahifasiga o'tamiz
                final result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const FieldsScreen();
                }));
              },
              title: const Text("Maydonlar"),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
