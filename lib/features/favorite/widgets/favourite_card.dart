import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab5ah/data/models/meal_model.dart';

import '../../meal/views/meal_details_view.dart';

class FavouriteCard extends StatelessWidget {
  final Meal meal;
  const FavouriteCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context).textTheme;
    return InkWell(
      onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MealDetailsView(mealId: meal.idMeal),)),
      child: Container(
        height: 150,
        width:150,
        decoration: const BoxDecoration(
          border: Border.symmetric(vertical: BorderSide(color: Color(0xffFFBF78)),horizontal:  BorderSide(color: Color(0xffFFBF78))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExtendedImage.network(meal.strMealThumb,
                width: 130, height: 130),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width:150,
              child: Text(
                meal.strMeal,
                style: GoogleFonts.museoModerno(
                    color: const Color(0xff7B4019), fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
