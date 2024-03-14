import 'package:async_and_await/view/widgets/custom_snack_bar.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:async_and_await/view/widgets/secondary_button.dart';
import 'package:async_and_await/view/widgets/alert_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:async_and_await/constants.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _forgetPasswordController = TextEditingController();

  @override
  void dispose() {
    _forgetPasswordController.dispose();
    super.dispose();
  }

  //Alert message Method
  void _alertDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialogBox(
          [
            Image.asset('images/magnifier.webp'),
            const Text(
              'Check Your Email!',
              style: kHeading2TextStyle,
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'We’ve sent a password reset link to Inbox',
                style: kNormalTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            PrimaryButton(
              title: 'Check Inbox',
              process: () async {
                await LaunchApp.openApp(
                  androidPackageName: 'com.google.android.gm',
                  openStore: false,
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'After resetting the password you can now login to Madhack with your new password',
                style: kNormalTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SecondaryButton(
              title: 'Login Now',
              process: () {
                context.go('/sign_in');
              },
            ),
          ],
        );
      },
    );
  }

// Forget password Method
  Future forgetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _forgetPasswordController.text.trim(),
      );
      _alertDialog();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _forgetPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Enter a valid email address', kAmberColor, 3),
        );
        // Handle invalid email address
      } else if (e.code == 'user-not-found') {
        _forgetPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('User not Found', kAmberColor, 3),
        );
      } else if (e.code == 'too-many-requests') {
        _forgetPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Maximum attempt count reached', kAmberColor, 3),
        );
      } else {
        // Handle other FirebaseAuthExceptions
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              repeat: ImageRepeat.repeat,
              image: AssetImage('assets/images/noise.webp'),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                  child: Text(
                    'Forgot Password? \n No Matter!',
                    textAlign: TextAlign.center,
                    style: kHeading1TextStyle,
                  ),
                ),
                const Image(
                  image: AssetImage('assets/images/keys.webp'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Enter your email account to reset password',
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 28.0),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _forgetPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Email';
                              }
                              return null; // Return null for valid input
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your email here',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      PrimaryButton(
                        title: 'Continue',
                        process: () {
                          if (_formKey.currentState!.validate()) {
                            // forgetPassword();
                            // Form is valid, proceed with submission or other actions
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SecondaryButton(
                    title: 'Cancel',
                    process: () {
                      context.go('/sign_in');
                    }),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
