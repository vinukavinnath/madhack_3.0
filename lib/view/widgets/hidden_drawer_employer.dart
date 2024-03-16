import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/pages/about_us.dart';
import 'package:async_and_await/view/pages/authentication/sign_in_page.dart';
import 'package:async_and_await/view/pages/employer/jobposting.dart';
import 'package:async_and_await/view/pages/help_support.dart';
import 'package:async_and_await/view/pages/home_page_applicant.dart';
import 'package:async_and_await/view/pages/invite_friends.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawerEmployer extends StatefulWidget {
  const HiddenDrawerEmployer({super.key});

  @override
  State<HiddenDrawerEmployer> createState() => _HiddenDrawerEmployerState();
}

class _HiddenDrawerEmployerState extends State<HiddenDrawerEmployer> {
  List<ScreenHiddenDrawer> _pages = [];
  final selectedTextStyle = const TextStyle(
    fontSize: 18,
    color: kWhiteColor,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Home',
            baseStyle: selectedTextStyle,
            selectedStyle: kHeading1TextStyle),
        JobPosting(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Help & Support',
            baseStyle: selectedTextStyle,
            selectedStyle: kHeading1TextStyle),
        const HelpSupport(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'About Us',
            baseStyle: selectedTextStyle,
            selectedStyle: kHeading1TextStyle),
        const AboutUs(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Invite Friends',
            baseStyle: selectedTextStyle,
            selectedStyle: kHeading1TextStyle),
        const InviteFriends(),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: kOceanBlueColor,
      initPositionSelected: 0,
      slidePercent: 50,
      isDraggable: true,
      actionsAppBar: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInPage(),
                ),
              );
            },
            icon: const Icon(Icons.logout)),
      ],
    );
  }
}
