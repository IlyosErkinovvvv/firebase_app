import 'package:firebase_app/core/extension/context_size.dart';
import 'package:firebase_app/provider/auth/sign_up_provider.dart';
import 'package:firebase_app/view/home_page.dart';
import 'package:firebase_app/view/Register/sign_in_page.dart';
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
      builder: (context, child) {
        return _scaffold(context);
      },
    );
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05, vertical: context.height * 0.03),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: "Enter your name",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * 0.025),
              child: TextFormField(
                controller: context.watch<SignUpProvider>().emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: "Enter your email",
                ),
              ),
            ),
            TextFormField(
              controller: context.watch<SignUpProvider>().passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: "Enter your password",
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()));
              },
              child: const Text("Sign in")),
          FloatingActionButton.extended(
              onPressed: () async {
                await context.read<SignUpProvider>().signUp().then((value) {
                  if (value == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                });
              },
              label: !context.watch<SignUpProvider>().isLoading
                  ? const Text("Ro'yhatdan o'tish")
                  : const CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}
