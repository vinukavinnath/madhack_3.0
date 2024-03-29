import 'package:async_and_await/view/pages/authentication/sign_in_page.dart';
import 'package:async_and_await/view/pages/authentication/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const SignInPage();
            } else {
              return const SignUpPage();
            }
          },
        ),
      ),
    );
  }
}
