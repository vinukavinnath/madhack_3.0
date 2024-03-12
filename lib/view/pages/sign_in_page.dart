import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

  void setObsecure() {
    setState(() {
      obsecureController = !obsecureController;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Welcome Back!',
                                  style: kHeading1TextStyle,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ToggleSwitch(
                                  activeBgColor: const [kOceanBlueColor],
                                  activeFgColor: kDeepBlueColor,
                                  inactiveBgColor: kLightBlueColor,
                                  inactiveFgColor: kOceanBlueColor,
                                  cornerRadius: 10.0,
                                  radiusStyle: true,
                                  minWidth: screenWidth / 2,
                                  minHeight: 45.0,
                                  initialLabelIndex: 0,
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
                                  labels: const ['Applicant', 'Employer'],
                                  onToggle: null,
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    //Email Textfield
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 28.0),
                                      padding: const EdgeInsets.symmetric(
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
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email',
                                        ),
                                      ),
                                    ),
                                    //Password Textfield
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 28.0,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: TextFormField(
                                        controller: passwordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
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
                                                ? const Icon(
                                                    Icons.visibility_off)
                                                : const Icon(Icons.visibility),
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
                              PrimaryButton(title: "Log In", process: () {}),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot your Password',
                                  style: TextStyle(
                                    color: kDarkGreyColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AuthContainer(
                                    imagePath: "assets/logos/apple.webp",
                                    function: null,
                                  ),
                                  AuthContainer(
                                    imagePath: "assets/logos/google.webp",
                                    function: null,
                                  ),
                                  AuthContainer(
                                    imagePath: "assets/logos/facebook.webp",
                                    function: null,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Don\'t have an account?'),
                                  TextButton(
                                    onPressed: () {},
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
