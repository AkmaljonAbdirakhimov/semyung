import 'package:flutter/material.dart';

import '../providers/authentication_provider.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authenticationProvider = AuthenticationProvider();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos email kiriting";
                  }

                  if (!value.contains("@") && value.length > 3) {
                    return "Iltimos to'g'ri email kiriting";
                  }

                  // xatolik yo'q
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Parol",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos parol kiriting";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () async {
                  // formani tekshirish ya'ni email va parol kiritilganmi yoki yo'q
                  if (formKey.currentState!.validate()) {
                    // Foydalanuvchini tizimga kirish
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      await authenticationProvider.login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      // context.mounted = context mavjudmi yoki yo'q tekshiradi
                      // context esa bu widgetlar va sahifalar haqida ma'lumotga ega bo'lgan element
                      if (context.mounted) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const HomeScreen();
                        }));
                      }
                    } catch (error) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error.toString()),
                          ),
                        );
                      }
                    }

                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("LOGIN"),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) {
                    return const RegisterScreen();
                  }));
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
