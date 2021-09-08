import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/firebase_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: FirebaseScreen(),
    );
  }
}
