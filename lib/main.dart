import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tab5ah/features/favorite/cubit/favourite_cubit.dart';
import 'package:tab5ah/features/home/views/home_view.dart';
import 'package:tab5ah/features/likes/cubit/likes_cubit.dart';
import 'package:tab5ah/features/profile/presentation/Cubit/user_cubit.dart';
import 'package:tab5ah/features/search/cubit/search_cubit.dart';
import 'package:tab5ah/features/shopping_list/cubit/shopping_list_cubit.dart';
import 'package:tab5ah/starting_views/splash_screen.dart';
import 'package:tab5ah/starting_views/start_screen.dart';
import 'features/authenticate/data/repositories/auth_repository_impl.dart';
import 'features/authenticate/domain/use_cases/auth_usecases.dart';
import 'features/authenticate/presentation/manager/auth_cubit.dart';
import 'config/themes/app_theme.dart';
import 'features/authenticate/presentation/pages/sign_in.dart';
import 'features/authenticate/presentation/pages/sign_up.dart';
import 'features/category_filteration/cubit/filter_cubit.dart';
import 'features/meal/cubit/meals_cubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            signInUseCase: SignInUseCase(FirebaseAuthRepository()),
            registerUseCase: RegisterUseCase(FirebaseAuthRepository()),
          ),
        ),
        BlocProvider(create: (context) => MealsCubit(),),
        BlocProvider(create: (context) => SearchCubit(),),
        BlocProvider(create: (context) => FilterCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => FavouriteCubit()),
        BlocProvider(create: (context) => ShoppingListCubit()),
        BlocProvider(create: (context) => LikesCubit()),

      ],
      child:  ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          theme: AppTheme.getApplicationLightTheme(),
          darkTheme: AppTheme.getApplicationDarkTheme(),
          debugShowCheckedModeBanner: false,
          title: 'Tab5ah',
          // home: const SplashScreen(),
          initialRoute:
          FirebaseAuth.instance.currentUser == null ? "/" : "wrapper",
          routes: {
            "SignInPage": (context) => const SignIn(),
            "SignUpPage": (context) => const SignUp(),
            "/": (context) => const SplashScreen(),
            "wrapper": (context) => const AuthWrapper(),
          },
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return BlocProvider(
              create: (context) => AuthCubit(
                signInUseCase: SignInUseCase(FirebaseAuthRepository()),
                registerUseCase: RegisterUseCase(FirebaseAuthRepository()),
              ),
              child: const StartScreen(),
            );
          } else {
            return MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => AuthCubit(
                  signInUseCase: SignInUseCase(FirebaseAuthRepository()),
                  registerUseCase: RegisterUseCase(FirebaseAuthRepository()),
                ),
              ),
              BlocProvider(create: (context) => MealsCubit(),),
              BlocProvider(create: (context) => SearchCubit(),),
              BlocProvider(create: (context) => FilterCubit()),
              BlocProvider(create: (context) => UserCubit()),
              BlocProvider(create: (context) => FavouriteCubit()),
              BlocProvider(create: (context) => ShoppingListCubit()),
              BlocProvider(create: (context) => LikesCubit()),

            ],child: const HomeView());
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

