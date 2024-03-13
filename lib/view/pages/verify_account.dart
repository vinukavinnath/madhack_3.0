import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:async_and_await/view/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:async_and_await/view/widgets/custom_snack_bar.dart';
import 'package:async_and_await/constants.dart';
import 'package:go_router/go_router.dart';

class VerifyAccount extends StatelessWidget {
  const VerifyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    void checkEmailVerification() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        await user.reload(); // Reload user data to get the latest information
        if (user.emailVerified) {
          if (context.mounted) {
            context.go('/choose_type');
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar('User\'s email is not verified.', kAmberColor, 3),
            );
          }
        }
      }
    }

    void resendVerificationEmail() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        try {
          await user.sendEmailVerification();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                  'Verification email sent successfully', kGreenColor, 3),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar('Error sending verification email', kRedColor, 3),
          );
        }
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeat,
            image: AssetImage('assets/images/noise.webp'),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
              child: Text(
                'Verify Your Email \nAddress',
                textAlign: TextAlign.center,
                style: kHeading1TextStyle.copyWith(height: 1.2),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Image(
                image: AssetImage('assets/images/mailbox.webp'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'We have just send email verification link to your ',
                    style: kNormalTextStyle,
                  ),
                  Text(
                    '_email',
                    style: kNormalTextStyle.copyWith(color: kDeepBlueColor),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Please check email and click on the link provided to \nverify your address.',
                    textAlign: TextAlign.center,
                    style: kNormalTextStyle,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  PrimaryButton(
                    title: 'Go to Email Inbox',
                    process: () async {
                      await LaunchApp.openApp(
                          androidPackageName: 'com.google.android.gm',
                          openStore: true);
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'If you haven’t received the link yet, \nPlease click on resend button',
                style: kNormalTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SecondaryButton(
              title: 'Resend',
              process: () {
                resendVerificationEmail();
              },
            ),
            SecondaryButton(
              title: 'Continue',
              process: () {
                checkEmailVerification();
              },
            ),
            const SizedBox(
              height: 60.0,
            ),
          ],
        ),
      ),
    );
  }
}
