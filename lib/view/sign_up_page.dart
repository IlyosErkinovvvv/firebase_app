import 'package:firebase_app/provider/auth/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      builder: (context, child) => _scaffold(),
    );
  }

  Scaffold _scaffold() {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Column(
        children: [
          TextFormField(),
        ],
      ),
    );
  }
}
