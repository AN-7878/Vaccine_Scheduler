import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Center(
        child: Text(
          "Logged in as $email",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
