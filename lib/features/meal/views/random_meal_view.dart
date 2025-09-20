import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab5ah/features/meal/cubit/meals_cubit.dart';
import 'package:tab5ah/features/meal/views/meal_details_view.dart';

class RandomMealView extends StatefulWidget {
  const RandomMealView({super.key});

  @override
  State<RandomMealView> createState() => _RandomMealViewState();
}

class _RandomMealViewState extends State<RandomMealView> {
  @override
  void initState() {
    context.read<MealsCubit>().fetchRandomMeal();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Just for you",style: theme.titleLarge,),
        actions: [
          IconButton(onPressed: () {
              context.read<MealsCubit>().fetchRandomMeal();
          }, icon: const Icon(Icons.replay_circle_filled_outlined))
        ],
      ),
      body: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          if (state is MealsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error: Loading meal details'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<MealsCubit>().fetchRandomMeal(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is MealsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MealsSuccess) {
            final meal = state.response.meals.first;
            return Column(
              children: [
                ExtendedImage.network(
                  meal.strMealThumb,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 12),
                Text(
                  meal.strMeal,
                  style: theme.bodyLarge?.copyWith(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  "from ${meal.strArea} kitchen",
                  style: theme.bodyMedium,
                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  "Preparation",
                  style: theme.titleMedium,
                ),
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    color: const Color(0xffFFEEA9),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        meal.strInstructions,
                        style: GoogleFonts.museoModerno(
                          color: const Color(0xff7B4019),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealDetailsView(mealId:meal.idMeal ),));
                  },
                  color: const Color(0xffFFBF78),
                  child: Text(
                    "Explore it →",
                    style: theme.bodyMedium,
                  ),
                ),



              ],
            );
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}
