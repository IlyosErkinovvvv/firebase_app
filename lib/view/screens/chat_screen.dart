import 'package:firebase_app/core/extension/context_size.dart';
import 'package:firebase_app/view/pages/chat_page.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat screen")),
      body: SizedBox(
        width: double.infinity,
        height: context.height * 0.08,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatPage()));
          },
          child: const ListTile(
            title: Text('Mobile'),
            subtitle: Text('Flutter developer'),
            trailing: Text('? ? ?'),
          ),
        ),
      ),
    );
  }
}
