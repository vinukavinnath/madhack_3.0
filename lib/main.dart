import 'package:async_and_await/screens/employer/jobposting.dart';
import 'package:async_and_await/screens/user/aboutpage1.dart';
import 'package:async_and_await/screens/user/dashboard/jobshowing.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/employer/description.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JobShowing(),
      debugShowCheckedModeBanner: false,
    );
  }
}