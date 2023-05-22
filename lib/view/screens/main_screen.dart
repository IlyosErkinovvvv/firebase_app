import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/provider/Home/home_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Screen")),
      body: StreamBuilder(
        stream: context.read<HomeProvider>().productStream,
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Server Error"),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Map<String, dynamic>> data = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              data.add(document.data() as Map<String, dynamic>);
            }).toList();
            if (data.isEmpty) {
              return const Center(
                child: Text("Hali Mahsulotlar Yo'q"),
              );
            } else {
              return PageView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image:
                                NetworkImage(data[index]['image'].toString()),
                          ),
                        ),
                      ),
                      Text(data[index]['title'].toString()),
                      Text(data[index]['desc'].toString()),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await FirebaseAuth.instance.signOut();
      }),
    );
  }
}
