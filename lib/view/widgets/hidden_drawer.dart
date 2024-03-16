import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/pages/home_page_applicant.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  final selectedTextStyle = const TextStyle(
    fontSize: 20,
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
              selectedStyle: const TextStyle()),
          const HomePageApplicant())
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
    );
  }
}
