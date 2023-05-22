import 'package:firebase_app/core/extension/context_size.dart';
import 'package:firebase_app/provider/add/add_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddProductProvider(),
      builder: (context, child) {
        if (context.watch<AddProductProvider>().isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.05,
                  vertical: context.height * 0.03),
              child: Column(
                children: [
                  const Text("Mahsulot qo'shing"),
                  TextFormField(
                    controller: context
                        .watch<AddProductProvider>()
                        .productNameController,
                    decoration:
                        const InputDecoration(hintText: "Mahsulot nomi"),
                  ),
                  TextFormField(
                    controller: context
                        .watch<AddProductProvider>()
                        .productDescController,
                    decoration:
                        const InputDecoration(hintText: "Mahsulot haqida"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AddProductProvider>().writeData();
                    },
                    child: const Text("Rasm Yuklash"),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
