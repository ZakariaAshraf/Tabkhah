import 'package:flutter/material.dart';
import 'package:tab5ah/starting_views/start_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const StartScreen()),
            (route) => false,
      );
    });
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/splash.png",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Center(child: Image.asset("assets/images/logo.png",width: 200,height: 200,)),
          ],
        ),
      ),
    );
  }
}
