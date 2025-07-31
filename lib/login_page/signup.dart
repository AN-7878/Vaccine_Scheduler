import 'package:flutter/material.dart';
import 'login.dart'; // to access fakeUserDB

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';
  String role = 'Parent';

  void signUp() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (fakeUserDB.containsKey(email)) {
      setState(() {
        message = "User already exists!";
      });
    } else {
      fakeUserDB[email] = {
        'password': password,
        'role': role,
      };
      setState(() {
        message = "Account created! You can now login.";
      });
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: role,
              items: const [
                DropdownMenuItem(value: 'Parent', child: Text('Parent')),
                DropdownMenuItem(value: 'Staff', child: Text('Staff')),
              ],
              onChanged: (value) {
                setState(() {
                  role = value!;
                });
              },
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: signUp, child: const Text("Create Account")),
            const SizedBox(height: 10),
            Text(message, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}