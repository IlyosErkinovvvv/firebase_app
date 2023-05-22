
import 'package:firebase_app/helper/show_message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  // CONTROLLERS . . .
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // VARIABLES . . .
  bool isLoading = false;

  // To user sign in . . .
  Future<dynamic> signIn() async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorMessage('User not found');
        debugPrint("User not found");
        isLoading = false;
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        showErrorMessage('Wrong password');
        debugPrint("Wrong password");
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
