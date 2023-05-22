import 'package:firebase_app/provider/Home/home_provider.dart';
import 'package:firebase_app/provider/add/add_product_provider.dart';
import 'package:firebase_app/provider/auth/Sign%20In/sign_in_provider.dart';
import 'package:firebase_app/provider/auth/Sign%20Up/sign_up_provider.dart';
import 'package:firebase_app/provider/chat/chat_provider.dart';
import 'package:firebase_app/view/pages/Splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ChangeNotifierProvider(create: (context) => SignInProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => AddProductProvider()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
