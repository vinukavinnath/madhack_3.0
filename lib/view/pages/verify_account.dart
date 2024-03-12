import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:async_and_await/view/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:async_and_await/constants.dart';

class VerifyAccount extends StatelessWidget {
  const VerifyAccount({super.key});

  @override
  Widget build(BuildContext context) {
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
                      // await LaunchApp.openApp(
                      //     androidPackageName: 'com.google.android.gm',
                      //     openStore: true);
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
              process: () {},
            ),
            SecondaryButton(
              title: 'Continue',
              process: () {},
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
