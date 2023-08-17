// Enter Name::  
// Baxolash:
// 1. Dio task: 20 ball.
// 2. Firebase task : 20 ball.
// 3. Map task : 20 ball.
// 4. Custom Paint and Animations: 20 ball.
// 5. Suxbat: 20 ball

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Example"),
        ),
      )
    );
  }
}