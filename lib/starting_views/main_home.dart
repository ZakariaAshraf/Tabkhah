import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tab5ah/features/home/views/home_view.dart';
import 'package:tab5ah/features/search/views/search_screen.dart';

class Tab5ahMainHome extends StatelessWidget {
  const Tab5ahMainHome({super.key});

  static final List<Map<String, dynamic>> _screens = [
    {"icon": Icons.home_outlined},
    {"icon": Icons.favorite_outline_outlined},
    {"icon": Icons.search_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: [
         const HomeView(),
        Container(),
        const SearchScreen(),
      ],
      items: _screens
          .map(
            (e) => PersistentBottomNavBarItem(
              icon: Icon(e["icon"]),
              activeColorPrimary: const Color(0xff7B4019),
              inactiveColorPrimary: Colors.grey,
            ),
          )
          .toList(),
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: const NavBarDecoration(
          colorBehindNavBar: Color.fromRGBO(83, 83, 83, 0.6),
          borderRadius: BorderRadius.zero),
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
