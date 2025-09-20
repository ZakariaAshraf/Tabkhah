import 'package:flutter/material.dart';
import 'package:tab5ah/features/favorite/views/favourite_screen.dart';
import 'package:tab5ah/features/home/views/home_view.dart';
import 'package:tab5ah/features/meal/views/random_meal_view.dart';
import 'package:tab5ah/features/profile/presentation/screens/setting_view.dart';

import '../../shopping_list/views/shopping_list_screen.dart';


class CustomDrawerView extends StatelessWidget {
  const CustomDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 128.0,
              height: 128.0,
              margin: const EdgeInsets.only(
                top: 24.0,
                bottom: 64.0,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/images/logo.png"),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const HomeView(),
                  ),
                );
              },
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavouriteScreen(),
                  ),
                );
              },
              leading: const Icon(Icons.bookmark_border_outlined),
              title: const Text('Saved recipes'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingListScreen(),
                  ),
                );
              },
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('Your shopping list'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RandomMealView(),
                  ),
                );
              },
              leading: const Icon(Icons.set_meal_outlined),
              title: const Text('Your random meal'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingView(),
                  ),
                );
              },
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
            ),
            const Spacer(),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: const Text('Terms of Service | Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}