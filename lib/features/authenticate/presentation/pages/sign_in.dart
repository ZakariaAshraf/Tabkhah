import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab5ah/components/custom_button.dart';
import 'package:tab5ah/components/custom_text_field.dart';
import 'package:tab5ah/config/utils/app_colors.dart';
import 'package:tab5ah/features/authenticate/presentation/pages/sign_up.dart';
import 'package:tab5ah/features/home/views/home_view.dart';
import 'package:tab5ah/starting_views/start_screen.dart';

import '../manager/auth_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartScreen(),
                  ));
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ));
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                // Container(
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage(
                //         "assets/images/food.jpg",
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 138,
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 134,
                          height: 134,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                          controller: emailController, hintText: "Email"),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        isPassword: true,
                          controller: passwordController, hintText: "Password"),
                      InkWell(
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: emailController.text);
                            } catch (e) {
                              // TODO
                              if (kDebugMode) {
                                print(e.toString());
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.all(10),
                            child: const Text(
                              "Forget Password ?",
                              style: TextStyle(color: AppColors.secondery),
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      //sign in button
                      Center(
                        child: CustomButton(
                          title: "Login",
                          onTap: () {
                            context.read<AuthCubit>().signIn(
                                  emailController.text,
                                  passwordController.text,
                                );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Text("Don't have an account",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUp(),
                                  ));
                            },
                            child: const Text(
                              "Create!",
                              style: TextStyle(
                                color: Color(
                                  0xff1F4C6B,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
