import 'package:firebase_app/data/remote/firestore_service.dart';
import 'package:firebase_app/helper/show_message_widget.dart';
import 'package:flutter/material.dart';

class AddProductProvider extends ChangeNotifier {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  bool isLoading = false;

  void writeData() async {
    isLoading = true;
    notifyListeners();
    await ChatagramFirestoreService.writeData(
            title: productNameController.text,
            desc: productDescController.text,
            img:
                "https://support.apple.com/library/content/dam/edam/applecare/images/en_US/iphone/iphone-14-pro-colors.png")
        .then((value) {
      if (value == true) {
        isLoading = false;
        notifyListeners();
        showErrorMessage("Mahsulot qoshildi");
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
