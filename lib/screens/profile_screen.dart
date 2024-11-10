import 'package:flutter/material.dart';
import 'package:semyung/providers/authentication_provider.dart';
import 'package:semyung/screens/fields_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = AuthenticationProvider();
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: authenticationProvider.getUser(),
                builder: (context, snapshot) {
                  final user = snapshot.data;
                  return Text(user?.email ?? '-------');
                }),
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
            const Spacer(),
            ListTile(
              onTap: () async {
                await authenticationProvider.logout();
              },
              title: const Text(
                "Chiqish",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              trailing: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
