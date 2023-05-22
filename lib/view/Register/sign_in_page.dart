import 'package:firebase_app/core/extension/context_size.dart';
import 'package:firebase_app/provider/auth/sign_in_provider.dart';
import 'package:firebase_app/view/home_page.dart';
import 'package:firebase_app/view/Register/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SignInProvider(),
        builder: (context, child) {
          return _scaffold(context);
        });
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05, vertical: context.height * 0.03),
        child: Column(
          children: [
            TextFormField(
              controller: context.watch<SignInProvider>().emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: "Enter your email",
              ),
            ),
            SizedBox(
              height: context.height * 0.025,
            ),
            TextFormField(
              controller: context.watch<SignInProvider>().passwordController,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()));
            },
            child: const Text("Sign in"),
          ),
          FloatingActionButton.extended(
              onPressed: () async {
                await context.read<SignInProvider>().signIn().then((value) {
                  if (value == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                });
              },
              label: !context.watch<SignInProvider>().isLoading
                  ? const Text("Next")
                  : const CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}
