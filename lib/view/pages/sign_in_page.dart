import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:async_and_await/constants.dart';

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
                              const SizedBox(
                                height: 30.0,
                              ),
                              const Text(
                                'Welcome Back!',
                                style: kHeading1TextStyle,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       vertical: 16.0),
                              //   child: Container(
                              //     // margin: EdgeInsets.symmetric(horizontal: 20.0),
                              //     // width: screenWidth,
                              //     child: ToggleSwitch(
                              //       activeBgColor: const [
                              //         kOceanBlueColor
                              //       ],
                              //       activeFgColor: kDeepBlueColor,
                              //       inactiveBgColor: kLightBlueColor,
                              //       inactiveFgColor: kOceanBlueColor,
                              //       cornerRadius: 10.0,
                              //       radiusStyle: true,
                              //       minWidth: screenWidth / 2,
                              //       minHeight: 45.0,
                              //       initialLabelIndex: currentUserRole,
                              //       totalSwitches: 2,
                              //       customTextStyles: const [
                              //         TextStyle(
                              //             fontSize: 15.0,
                              //             fontWeight: FontWeight.w600),
                              //         TextStyle(
                              //             fontSize: 15.0,
                              //             fontWeight: FontWeight.w600),
                              //       ],
                              //       animate: true,
                              //       curve: Curves.ease,
                              //       labels: const [
                              //         'Freelancer',
                              //         'Client'
                              //       ],
                              //       onToggle: _onToggle,
                              //     ),
                              //   ),
                              // ),
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
                              // Container(
                              //   width: screenWidth,
                              //   padding: const EdgeInsets.symmetric(
                              //       vertical: 8.0, horizontal: 28.0),
                              //   child: ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       padding: const EdgeInsets.symmetric(
                              //         vertical: 6.0,
                              //         horizontal: 24.0,
                              //       ),
                              //       backgroundColor: kLightBlueColor,
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(16.0),
                              //       ),
                              //     ),
                              //     onPressed: () {},
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child:
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [
                              //           Image.asset(
                              //             'icons/google.png',
                              //             width: 25.0,
                              //           ),
                              //           const SizedBox(width: 15.0),
                              //           const Text(
                              //             'Google',
                              //             style: TextStyle(
                              //                 color: kDeepBlueColor,
                              //                 fontSize: 15.0,
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 75,
                                    height: 75,
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/logos/apple.webp',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 75,
                                    height: 75,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0,vertical: 10.0),
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/logos/google.webp',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 75,
                                    height: 75,
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/logos/facebook.webp',
                                      ),
                                    ),
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
