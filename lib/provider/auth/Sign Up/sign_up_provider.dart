import 'package:firebase_app/helper/show_message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  // CONTROLLERS . . .
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // VARIABLES . . .
  bool isLoading = false;

  // To user sign up . . .
  Future<dynamic> signUp() async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorMessage('Weak password');
        debugPrint("Weak password");
        isLoading = false;
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage('Email already in use');
        debugPrint("Email already in use");
        isLoading = false;
        notifyListeners();
      } else {
        showErrorMessage("Unknown error");
        debugPrint("Unknown error");
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
