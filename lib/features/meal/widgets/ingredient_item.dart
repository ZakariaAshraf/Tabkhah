import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab5ah/data/models/meal_model.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  const IngredientItem({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFFBF78),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xff7B4019),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              ingredient.name,
              style: GoogleFonts.museoModerno(
                color: const Color(0xff7B4019),
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              ingredient.measure,
              style: GoogleFonts.museoModerno(
                color: const Color(0xff7B4019),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
