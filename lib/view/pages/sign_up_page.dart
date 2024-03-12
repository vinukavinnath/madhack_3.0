import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:async_and_await/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked1 = false;
  bool isChecked2 = false;

  bool obsecureController0 = true;
  bool obsecureController1 = true;
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // void createMyAccount() async {
  //   final String enteredEmail = email.text.trim();
  //   final String enteredPassword = password.text.trim();
  //   final String confirmPassword = confirmPasswordController.text.trim();
  //   try {
  //     if (enteredPassword == confirmPassword) {
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: enteredEmail,
  //         password: enteredPassword,
  //       );
  //       sendVerificationLink(email.text);
  //
  //       Fluttertoast.showToast(
  //         msg: "Account was successfully created",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 2,
  //         backgroundColor: Colors.blue,
  //         textColor: Colors.white,
  //         fontSize: 24.0,
  //
  //         // Account creation successful
  //       );
  //     } else if (enteredPassword != confirmPassword) {
  //       // Show a snackbar if passwords don't match
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         CusSnackBar(
  //           title: 'Password does not match',
  //           backColor: kWarningRedColor,
  //           time: 3,
  //         ),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       // The password provided is too weak
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         CusSnackBar(
  //           title: 'Weak password',
  //           backColor: kWarningRedColor,
  //           time: 3,
  //         ),
  //       );
  //     } else if (e.code == 'email-already-in-use') {
  //       // The account already exists for that email
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         CusSnackBar(
  //           title: 'Email already in use',
  //           backColor: kWarningRedColor,
  //           time: 3,
  //         ),
  //       );
  //     }
  //   }
  // }

  bool isCreateAccountButtonActive() {
    if (isChecked1 == true && isChecked2 == true) {
      return true;
    } else {
      return false;
    }
  }

  void setObsecure0() {
    setState(() {
      obsecureController0 = !obsecureController0;
    });
  }

  void setObsecure1() {
    setState(() {
      obsecureController1 = !obsecureController1;
    });
  }

  // void _navigateToVerifyEmail() {
  //   // Navigator.of(context).pushReplacement(
  //   //   MaterialPageRoute(
  //   //     builder: (context) => const VerifyEmail(),
  //   //   ),
  //   // );
  // }

  // Future<void> sendVerificationLink(String email) async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //
  //     if (user != null && !user.emailVerified) {
  //       await user.sendEmailVerification();
  //       _navigateToVerifyEmail();
  //     }
  //   } catch (e) {
  //     //Ignored catch block
  //   }
  // }
  //
  // Future<void> _showMarkdownDialog(BuildContext context) async {
  //   String markdownContent = await rootBundle.loadString('assets/11.md');
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Terms and Conditions'),
  //         content: SingleChildScrollView(
  //           child: Markdown(
  //             data: markdownContent,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/noise.webp'),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 8.0),
                      child: Text(
                        'Create My Account',
                        style: kHeading1TextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //"Email" Textfield goes here
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 28.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field can\'t be empty';
                                } else if (!value.contains('@')) {
                                  password.clear();
                                  confirmPasswordController.clear();
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
                          const SizedBox(
                            height: 10.0,
                          ),
                          //"Password" Textfield goes here
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 28.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field can\'t be empty';
                                }
                                return null; // Return null for valid input
                              },
                              obscureText: obsecureController0,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  icon: obsecureController0
                                      ? const Icon(
                                          Icons.visibility_off_rounded)
                                      : const Icon(Icons.visibility_rounded),
                                  color: kBlackColor,
                                  onPressed: () {
                                    setObsecure0();
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          //"Confirm Password" Textfield goes here
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 28.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field can\'t be empty';
                                }
                                return null; // Return null for valid input
                              },
                              obscureText: obsecureController1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  icon: obsecureController1
                                      ? const Icon(
                                          Icons.visibility_off_rounded)
                                      : const Icon(Icons.visibility_rounded),
                                  color: kBlackColor,
                                  onPressed: () {
                                    setObsecure1();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: Checkbox(
                          value: isChecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked1 = value!;
                            });
                          },
                          activeColor: kDeepBlueColor,
                        ),
                        title: Wrap(
                          children: [
                            const Text(
                              'I have read and agree to MadHack’s',
                              style: kNormalTextStyle,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => const TermsConditions(),
                                //   ),
                                // );
                              },
                              child: const Text(
                                'Term of Service',
                                style: kNormalTextStyle,
                              ),
                            ),
                            const Text(
                              ' and',
                              style: kNormalTextStyle,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => const PrivacyPolicy(),
                                //   ),
                                // );
                              },
                              child: const Text(
                                ' Privacy Policy',
                                style: kNormalTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: Checkbox(
                          value: isChecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked2 = value!;
                            });
                          },
                          activeColor: kDeepBlueColor,
                        ),
                        title: const Wrap(
                          children: [
                            Text(
                              'We reserve the right to terminate or suspend your account at any time for violating our policies.',
                              style: kNormalTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: PrimaryButton(
                        title: 'Create My Account',
                        process: () {
                          if (_formKey.currentState!.validate()) {
                            // Form is valid, proceed with submission or other actions
                            if (isCreateAccountButtonActive()) {
                              // createMyAccount();
                            } else {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   CusSnackBar(
                              //     title: 'Please agree to Terms & Conditions',
                              //     backColor: kWarningRedColor,
                              //     time: 3,
                              //   ),
                              // );
                            }
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Already registered?'),
                        TextButton(
                          onPressed: () {
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (context) => const Login(),
                            //   ),
                            // );
                          },
                          child: const Text(
                            'Log In',
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
      ),
    );
  }
}
