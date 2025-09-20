import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab5ah/features/profile/presentation/screens/setting_screen.dart';

import '../Cubit/user_cubit.dart';
class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getCurrentUserData(),
      child: Scaffold(
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return SettingScreen(
                name: state.user.name,
                phone: state.user.phone,

              );
              // return Scaffold(
              //   appBar: AppBar(),
              //   body: Column(
              //     children: [
              //       ListTile(
              //         title: Text(state.user.name),
              //         trailing: Text(state.user.nationality),
              //         subtitle: Text(state.user.phone),
              //       )
              //     ],
              //   ),
              // );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}