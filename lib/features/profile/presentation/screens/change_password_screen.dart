// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../config/utils/app_colors.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text("Please write your Email Address"),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                label: const Text("Email"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: emailController.text);
                  // AwesomeDialog(
                  //         animType: AnimType.leftSlide,
                  //         context: context,
                  //         dialogType: DialogType.info,
                  //         btnOkOnPress: () {},
                  //         title: "Warning",
                  //         desc: "Check your email address")
                  //     .show();
                  setState(() {});
                } catch (e) {
                  if (kDebugMode) {
                    print(e.toString());
                  }
                }
              },
              color: AppColors.primary,
              child: const Text("Change password"),
            ),
          ],
        ),
      ),
    );
  }
}
