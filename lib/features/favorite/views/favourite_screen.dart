import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab5ah/features/favorite/cubit/favourite_cubit.dart';

import '../../../components/default_message_card.dart';
import '../widgets/favourite_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        centerTitle: true,
      ),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteInitial) {
            return const DefaultMessageCard(
              sign: '0_0',
              title: "You don't like anything ",
              subTitle: "favorite",
            );
          } else if (state is FavouriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavouriteSuccess) {
            return Expanded(
              child: GridView.builder(itemBuilder: (context, index) {
                return FavouriteCard(meal: state.meals[index]);
              },itemCount: state.meals.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),),
            );
          } else {
            return Center(
              child: ElevatedButton(onPressed: () =>context.read<FavouriteCubit>().loadFavorites() , child: const Text("Reload page")),
            );
          }
        },
      ),
    );
  }
}
