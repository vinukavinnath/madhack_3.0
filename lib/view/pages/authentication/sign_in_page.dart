import 'package:async_and_await/view/pages/authentication/forgot_password.dart';
import 'package:async_and_await/view/pages/authentication/sign_up_page.dart';
import 'package:async_and_await/view/pages/home_page_applicant.dart';
import 'package:async_and_await/view/pages/home_page_employer.dart';
import 'package:async_and_await/view/widgets/custom_snack_bar.dart';
import 'package:async_and_await/view/widgets/loading_screen.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/widgets/auth_container.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obsecureController = true;
  int currentUserRole = 0;
  bool isLoading = false;

  void setObsecure() {
    setState(() {
      obsecureController = !obsecureController;
    });
  }

  void _onToggle(int? index) {
    setState(() {
      currentUserRole = index!;
    });
  }

  void signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // Sign-in successful, handle the user object or navigate to the next screen.

      if (context.mounted) {
        (currentUserRole == 0)
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePageApplicant()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePageEmployer()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-mail') {
        emailController.clear();
        passwordController.clear();
        //Visit the snackbar class for further details
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Enter a valid email address', kAmberColor, 3),
        );
      } else if (e.code == 'user-not-found') {
        emailController.clear();
        passwordController.clear();
        //Visit the snackbar class for further details
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Incorrect Email and Password', kAmberColor, 3),
        );
      } else if (e.code == 'wrong-password') {
        passwordController.clear();
        //Visit the snackbar class for further details
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar('Incorrect Password', kAmberColor, 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: isLoading
          ? const LoadingScreen(
              title: 'Authenticating. . . ',
            )
          : Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  color: kDeepBlueColor,
                  // image: DecorationImage(
                  //   fit: BoxFit.fill,
                  //   image: AssetImage(""),
                  // ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/logos/madhack.webp'),
                    ),
                    Expanded(
                      flex: 6,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(45.0),
                                topRight: Radius.circular(45.0),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            bottom: 0,
                            child: Container(
                              width: screenWidth,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/noise.webp'),
                                  repeat: ImageRepeat.repeat,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: ListView(
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          'Welcome Back!',
                                          style: kHeading1TextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: ToggleSwitch(
                                          activeBgColor: const [
                                            kOceanBlueColor
                                          ],
                                          activeFgColor: kDeepBlueColor,
                                          inactiveBgColor: kLightBlueColor,
                                          inactiveFgColor: kOceanBlueColor,
                                          cornerRadius: 10.0,
                                          radiusStyle: true,
                                          minWidth: screenWidth / 2,
                                          minHeight: 45.0,
                                          initialLabelIndex: currentUserRole,
                                          totalSwitches: 2,
                                          customTextStyles: const [
                                            TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600),
                                            TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600),
                                          ],
                                          animate: true,
                                          curve: Curves.ease,
                                          labels: const [
                                            'Applicant',
                                            'Employer'
                                          ],
                                          onToggle: _onToggle,
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: <Widget>[
                                            //Email Textfield
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 28.0),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              decoration: BoxDecoration(
                                                color: kWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child:
                                                  //Email Textfield
                                                  TextFormField(
                                                controller: emailController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      !value.contains('@')) {
                                                    return 'Please enter a valid Email Address';
                                                  }
                                                  return null; // Return null for valid input
                                                },
                                                obscureText: false,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Email',
                                                ),
                                              ),
                                            ),
                                            //Password Textfield
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 28.0,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              decoration: BoxDecoration(
                                                color: kWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: TextFormField(
                                                controller: passwordController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter the Password';
                                                  }
                                                  return null; // Return null for valid input
                                                },
                                                obscureText: obsecureController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Password',
                                                  suffixIcon: IconButton(
                                                    icon: obsecureController
                                                        ? const Icon(Icons
                                                            .visibility_off)
                                                        : const Icon(
                                                            Icons.visibility),
                                                    color: kBlackColor,
                                                    onPressed: () {
                                                      setObsecure();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //"Log In" Button goes here
                                      PrimaryButton(
                                          title: "Log In",
                                          process: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              CollectionReference
                                                  collectionReference =
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          (currentUserRole == 0)
                                                              ? 'User'
                                                              : 'Employer');

                                              setState(() {
                                                isLoading = true;
                                              });

                                              var snapshots =
                                                  collectionReference
                                                      .snapshots();
                                              late bool isUserFound = false;
                                              snapshots.forEach((snapshot) {
                                                for (var doc in snapshot.docs) {
                                                  print(doc.id);
                                                  if (doc.id ==
                                                      emailController.text) {
                                                    signInWithEmailAndPassword(
                                                      emailController.text
                                                          .trim(),
                                                      passwordController.text
                                                          .trim(),
                                                    );
                                                    setState(() {
                                                      isUserFound = true;
                                                    });
                                                    break;
                                                  }
                                                }
                                              });
                                            }
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ForgotPassword()));
                                        },
                                        child: const Text(
                                          'Forgot your Password',
                                          style: TextStyle(
                                            color: kDarkGreyColor,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Center(
                                              child: Container(
                                                height: 3.0,
                                                width: screenWidth / 4,
                                                color: kLightBlueColor,
                                              ),
                                            ),
                                            const Text(
                                              'Or continue with',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                height: 3.0,
                                                width: screenWidth / 4,
                                                color: kLightBlueColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          AuthContainer(
                                            imagePath:
                                                "assets/logos/apple.webp",
                                            function: null,
                                          ),
                                          AuthContainer(
                                            imagePath:
                                                "assets/logos/google.webp",
                                            function: null,
                                          ),
                                          AuthContainer(
                                            imagePath:
                                                "assets/logos/facebook.webp",
                                            function: null,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Text('Don\'t have an account?'),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SignUpPage()));
                                            },
                                            child: const Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                color: kAmberColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
