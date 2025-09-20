import 'package:flutter/material.dart';
import 'package:tab5ah/components/custom_button.dart';
import 'package:tab5ah/config/utils/app_colors.dart';
import '../features/authenticate/presentation/pages/sign_in.dart';
import '../features/authenticate/presentation/pages/sign_up.dart';
import '../features/home/views/home_view.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Scaffold(
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
          Positioned(
              top: 100,
              left: 55,
              right: 55,
              child: Image.asset(
                "assets/images/logo.png",
                width: 134,
                height: 134,
              )),
          // Positioned(
          //     top: 270,
          //     left: 100,
          //     right: 55,
          //     child: Text("welcome to our cook app",style: theme.titleLarge,)),
          Positioned(
            top: 400,
            left: 55,
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Continue as a guest",
                    style: TextStyle(color: AppColors.secondery),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                  title: "Login",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ));
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                  title: "Register",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
