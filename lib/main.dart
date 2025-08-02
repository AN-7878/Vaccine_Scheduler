import 'package:flutter/material.dart';
import 'login_page/login.dart';

void main() {
  runApp(const VaccineScheduler());
}

class VaccineScheduler extends StatelessWidget {
  const VaccineScheduler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VACCINE SCHEDULER',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 170, 204, 233),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
