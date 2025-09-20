import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab5ah/components/aligned_flag.dart';
import 'package:tab5ah/components/methods.dart';
import 'package:tab5ah/config/utils/app_colors.dart';
import 'package:tab5ah/features/meal/cubit/meals_cubit.dart';
import 'package:tab5ah/features/meal/widgets/ingredient_item.dart';
import 'package:tab5ah/features/shopping_list/cubit/shopping_list_cubit.dart';
import '../../../data/models/meal_model.dart';
import '../../favorite/cubit/favourite_cubit.dart';
import '../../shopping_list/widgets/select_ingredients_dialog.dart';

class MealDetailsView extends StatefulWidget {
  final String mealId;

  const MealDetailsView({super.key, required this.mealId});

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  @override
  void initState() {
    context.read<MealsCubit>().fetchMealById(widget.mealId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Meal Details",
          style: GoogleFonts.museoModerno(
              color: const Color(0xff7B4019), fontSize: 15),
        ),
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
                        context.read<MealsCubit>().fetchMealById(widget.mealId),
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ExtendedImage.network(
                        meal.strMealThumb,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: BlocBuilder<FavouriteCubit, FavouriteState>(
                          builder: (context, state) {
                            final isFavorite = context
                                .read<FavouriteCubit>()
                                .isFavorite(meal.idMeal);
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<FavouriteCubit>()
                                    .addToFavourite(meal);
                                isFavorite
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                "removed from saved meals")))
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content:
                                                Text("added to saved meals")));
                              },
                              child: Icon(
                                isFavorite
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: isFavorite
                                    ? AppColors.primary
                                    : Colors.black,
                                size: 45,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    meal.strMeal,
                    style: GoogleFonts.museoModerno(
                        color: const Color(0xff7B4019),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "from ${meal.strArea} kitchen",
                    style: GoogleFonts.museoModerno(
                        color: const Color(0xff7B4019), fontSize: 13),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AlignedFlag(title: "Category", width: 140),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFBF78),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Center(
                      child: Text(
                        meal.strCategory,
                        style: GoogleFonts.museoModerno(
                          color: const Color(0xff7B4019),
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AlignedFlag(title: "Ingredients", width: 140),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: const Color(0xffFFEEA9),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              children:
                                  meal.ingredients.take(4).map((ingredient) {
                                return IngredientItem(ingredient: ingredient);
                              }).toList(),
                            ),
                            if (meal.ingredients.length > 2)
                              TextButton(
                                onPressed: () {
                                  _showAllIngredients(context, meal);
                                },
                                child: Text(
                                  "View All Ingredients",
                                  style: GoogleFonts.museoModerno(
                                    color: const Color(0xff7B4019),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AlignedFlag(title: "Instructions", width: 140),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      color: const Color(0xffFFEEA9),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
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
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Recipe resources",
                      style: GoogleFonts.museoModerno(
                          color: const Color(0xff7B4019),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                          radius: 30,
                          child: IconButton(
                            onPressed: () async {
                              await lunchInBrowser(
                                  meal.strYoutube ?? "www.youtube.com");
                            },
                            icon: Image.asset("assets/images/youtube.png"),
                          )),
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(
                          onPressed: () async {
                            await lunchInBrowser(
                                meal.strSource ?? "www.bbcgoodfood.com");
                          },
                          icon: const Icon(
                            Icons.file_copy_outlined,
                            color: Color(0xff7B4019),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _showAllIngredients(BuildContext context, Meal meal) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xffFFEEA9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "All Ingredients",
                style: GoogleFonts.museoModerno(
                  color: const Color(0xff7B4019),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: meal.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = meal.ingredients[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: IngredientItem(ingredient: ingredient),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7B4019),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Close",
                      style: GoogleFonts.museoModerno(
                        color: const Color(0xffFFEEA9),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7B4019),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      final selected = await showDialog<List<Ingredient>>(
                        context: context,
                        builder: (_) => SelectIngredientsDialog(
                            ingredients: meal.ingredients),
                      );
                      if (selected != null && selected.isNotEmpty) {
                        context.read<ShoppingListCubit>().addToList(selected);
                      }
                    },
                    child: Text(
                      "Add to shopping list",
                      style: GoogleFonts.museoModerno(
                        color: const Color(0xffFFEEA9),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
