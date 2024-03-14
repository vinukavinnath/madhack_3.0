import 'package:async_and_await/controller/router_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';

//Pages
import 'package:async_and_await/view/pages/sign_in_page.dart';
import 'package:async_and_await/view/pages/account_type.dart';
import 'package:async_and_await/view/pages/forgot_password.dart';
import 'package:async_and_await/view/pages/sign_up_page.dart';
import 'package:async_and_await/view/pages/verify_account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      routerConfig: routes,
      // home: const SafeArea(
      //   child: VerifyAccount(),
      // ),
    );
  }
}
