import 'package:async_and_await/controller/root_page.dart';
import 'package:async_and_await/view/pages/authentication/splash_screen.dart';
import 'package:async_and_await/view/pages/user/dashboard.dart';
import 'package:async_and_await/view/pages/user/dashboard/aboutme.dart';
import 'package:async_and_await/view/pages/user/dashboard/jobshowing.dart';
import 'package:async_and_await/view/widgets/hidden_drawer_employer.dart';
import 'package:async_and_await/view/widgets/hidden_drawer_user.dart';

import 'package:async_and_await/view/pages/employer/jobposting.dart';
import 'package:async_and_await/view/pages/user_profile_creation/aboutpage1.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Pages
import 'package:async_and_await/view/pages/authentication/sign_in_page.dart';
import 'package:async_and_await/view/pages/authentication/account_type.dart';
import 'package:async_and_await/view/pages/authentication/forgot_password.dart';
import 'package:async_and_await/view/pages/authentication/verify_account.dart';

import 'package:async_and_await/view/pages/user_profile_creation/aboutpage1.dart';

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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home:  SafeArea(
        child: SplashScreen(),
      ),
      // home: const SafeArea(
      //   child: VerifyAccount(),
      // ),
    );
  }
}
