import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/core/extension/context_size.dart';
import 'package:firebase_app/provider/chat/chat_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      builder: (context, child) => _scaffold(context),
    );
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: context.width * 0.02),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
        ),
        title: const Text("Telegram"),
      ),
      body: StreamBuilder(
        stream: context.read<ChatProvider>().messageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            List<Map<String, dynamic>> data = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              data.add(document.data() as Map<String, dynamic>);
            }).toList();
            if (data.isEmpty) {
              return const Center(
                child: Text("No message yet"),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(bottom: context.height * 0.08),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.height * 0.001),
                      child: Align(
                        alignment: data[index]['token'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.0,
                              vertical: context.height * 0.005),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.height * 0.01,
                                  horizontal: context.width * 0.03),
                              child: Text(
                                data[index]['message'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: context.height * 0.08,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.blue),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: TextFormField(
                  controller: context.watch<ChatProvider>().messageController,
                  decoration: InputDecoration(
                    hintText: " Write message ",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: context.width * 0.05),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    context.read<ChatProvider>().writeMessage();
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
