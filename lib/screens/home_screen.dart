import 'package:flutter/material.dart';
import 'package:semyung/screens/field_details_screen.dart';
import 'package:semyung/screens/profile_screen.dart';
import '../providers/field_provider.dart';
import '../models/field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey();
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Field> fields = FieldProvider.fields;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("SEMYUNG"),
        actions: [Container()],
      ),
      endDrawer: const ProfileScreen(),
      drawerEnableOpenDragGesture: false,
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
      bottomNavigationBar: Builder(builder: (context) {
        return BottomNavigationBar(
          selectedItemColor: Colors.blue,
          currentIndex: currentTabIndex,
          onTap: (value) {
            // 0 = HOME
            // 1 == PROFIL

            setState(() {
              currentTabIndex = value;
            });
            if (currentTabIndex == 1) {
              // yon oynani ochib beradi
              Scaffold.of(context).openEndDrawer();
            }
          },
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
        );
      }),
    );
  }
}
