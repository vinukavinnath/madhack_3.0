import 'package:async_and_await/view/pages/home_page_employer.dart';
import 'package:async_and_await/view/pages/user_profile_creation/aboutpage1.dart';
import 'package:async_and_await/view/widgets/hidden_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:async_and_await/constants.dart';

class AccountType extends StatefulWidget {
  const AccountType({super.key});

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  bool isWork = false;
  bool isHire = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kAshWhiteColor,
        body: Container(
          decoration: const BoxDecoration(
            color: kDeepBlueColor,
            // image: DecorationImage(
            //   fit: BoxFit.fill,
            //   image: AssetImage('images/background/take_action_1.webp'),
            // ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Image.asset('assets/logos/madhack.webp'),
              ),
              Expanded(
                flex: 5,
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
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    'Choose Your Account \nType',
                                    textAlign: TextAlign.center,
                                    style: kHeading1TextStyle,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isWork = true;
                                      isHire = false;
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AboutPage1(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32.0),
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                      color: isWork
                                          ? kOceanBlueColor
                                          : kLowOpacityLightBlueColor,
                                      border:
                                          Border.all(color: kOceanBlueColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 32.0),
                                          child: Text(
                                            'I\'m an Applicant',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: isWork
                                                  ? kAshWhiteColor
                                                  : kDeepBlueColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 30.0,
                                          ),
                                          width: screenWidth / 4,
                                          decoration: BoxDecoration(
                                            color: isWork
                                                ? const Color(0xFF1d58f5)
                                                : kLightBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: isWork
                                                ? kAshWhiteColor
                                                : kDeepBlueColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    'Or',
                                    style: TextStyle(
                                        color: kDarkGreyColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    await FirebaseFirestore.instance
                                        .collection('Employer')
                                        .doc(user!.email)
                                        .set({});
                                    setState(() {
                                      isWork = false;
                                      isHire = true;
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HiddenDrawer(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32.0),
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                      color: isHire
                                          ? kOceanBlueColor
                                          : kLowOpacityLightBlueColor,
                                      border:
                                          Border.all(color: kOceanBlueColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 32.0),
                                          child: Text(
                                            'I\'m an Employer',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: isHire
                                                  ? kAshWhiteColor
                                                  : kDeepBlueColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 30.0,
                                          ),
                                          width: screenWidth / 4,
                                          decoration: BoxDecoration(
                                            color: isHire
                                                ? const Color(0xFF1d58f5)
                                                : kLightBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: isHire
                                                ? kAshWhiteColor
                                                : kDeepBlueColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
      ),
    );
  }
}
