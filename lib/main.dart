import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'initialPage.dart';
// core Flutter primitives
import 'package:flutter/foundation.dart';
// core FlutterFire dependency
import 'package:firebase_core/firebase_core.dart';
// generated by



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions
        (apiKey: "AIzaSyBN8EdyxMs980RhhS2H_GM-Vrf-AzJCaXk",
          authDomain: "chat-fc34a.firebaseapp.com",
          projectId: "chat-fc34a",
          storageBucket: "chat-fc34a.appspot.com",
          messagingSenderId: "991398911545",
          appId: "1:991398911545:web:cc364a0baef0f3c10bf7e8")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InitialPage(),
    );
  }
}