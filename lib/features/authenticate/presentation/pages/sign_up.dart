import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab5ah/components/custom_button.dart';
import 'package:tab5ah/components/custom_text_field.dart';
import 'package:tab5ah/features/authenticate/presentation/pages/sign_in.dart';
import 'package:tab5ah/features/home/views/home_view.dart';

import '../../../../starting_views/start_screen.dart';
import '../manager/auth_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();

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
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
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
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Stack(
            children: [
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
                    CustomTextField(
                        controller: nameController, hintText: "Full name"),
                    const SizedBox(height: 15),
                    CustomTextField(
                        controller: emailController, hintText: "Email"),
                    const SizedBox(height: 15),
                    CustomTextField(isPassword: true,
                        controller: passwordController, hintText: "Password"),
                    const SizedBox(height: 15),
                    CustomTextField(
                        controller: phoneController, hintText: "Phone"),
                    // const SizedBox(height: 15),
                    // CustomTextField(
                    //     controller: nationalityController,
                    //     hintText: "Nationality"),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CustomButton(
                        title: "Register",
                        onTap: () {
                          context.read<AuthCubit>().register(
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                // nationality: nationalityController.text,
                                name: nameController.text,
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
                        const Text("Already have an account",
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignIn(),
                                ));
                          },
                          child: const Text(
                            "Login!",
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
      }),
    );
  }
}
