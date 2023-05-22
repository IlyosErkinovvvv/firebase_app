import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/data/remote/chat_service.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('message')
      .orderBy('created_at')
      .snapshots();

  void writeMessage() async {
    await ChatService.writeMessage(message: messageController.text);
    messageController.clear();
  }
}
