import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab5ah/data/models/meal_model.dart';
import 'package:tab5ah/features/meal/views/meal_details_view.dart';

class MealOverview extends StatelessWidget {
 final Meal meal ;
  const MealOverview({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context).textTheme;
    return InkWell(
      onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MealDetailsView(mealId: meal.idMeal),)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border.symmetric(horizontal: BorderSide(color: Color(0xffFFBF78)),),
          ),
          child: Row(
            children: [
              Image.network(meal.strMealThumb,
                  width: 150, height: 150),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    width:170,
                    child: Text(
                      meal.strMeal,
                      style: GoogleFonts.museoModerno(
                          color: const Color(0xff7B4019), fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "from ${meal.strArea} kitchen",
                    style: theme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // MaterialButton(
                  //   onPressed: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => MealView(meal: meal),));
                  //   },
                  //   color: const Color(0xffFFBF78),
                  //   child: Text(
                  //     "Explore it →",
                  //     style: GoogleFonts.museoModerno(
                  //         color: const Color(0xff7B4019),
                  //         fontSize: 12),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
