// ignore_for_file: prefer_final_fields, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meet_friends/screens/history.dart';
import 'package:meet_friends/screens/home.dart';
import 'package:meet_friends/screens/setting.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomTab extends StatefulWidget {
  BottomTab({assUserDetails});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int selectedIndex = 0;

  List<Widget> buildScreens() {
    return [
      const Home(),
      const History(),
      const Setting(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.video_camera_front_outlined),
        title: ("Chat & Meet"),
        inactiveColorPrimary: HexColor('#807E91'),
        activeColorPrimary: HexColor('#5AA6FF'),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: ("History"),
        inactiveColorPrimary: HexColor('#807E91'),
        activeColorPrimary: HexColor('#5AA6FF'),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings_applications_outlined),
        title: ("Settings"),
        inactiveColorPrimary: HexColor('#807E91'),
        activeColorPrimary: HexColor('#5AA6FF'),
      ),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(context,
          controller: _controller,
          screens: buildScreens(),
          items: navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: HexColor('#222634'),
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style8),
    );
  }
}
