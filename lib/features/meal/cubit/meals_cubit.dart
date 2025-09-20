import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/meal_model.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  MealsCubit() : super(MealsInitial());

  fetchRandomMeal() async {
    try {
      emit(MealsLoading());
      var url = Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php");
      var response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        MealResponse mealResponse = MealResponse.fromJson(jsonResponse);
        emit(MealsSuccess(mealResponse));
      } else {
        emit(MealsLoading());
      }
    } catch (e, trace) {
      if (kDebugMode) {
        print(trace.toString());
      }
    }
    return;
  }

  fetchMealById(String mealId) async {
    try {
      emit(MealsLoading());
      var url = Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId");
      var response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        MealResponse mealResponse = MealResponse.fromJson(jsonResponse);
        emit(MealsSuccess(mealResponse));
      } else {
        emit(MealsLoading());
      }
    } catch (e, trace) {
      if (kDebugMode) {
        print(trace.toString());
      }
    }
    return;
  }

  Future<List<Meal>> fetchMealsByIds(List<String> mealIds) async {
    try {
      emit(MealsLoading());

      final meals = await Future.wait(
        mealIds.map((mealId) => fetchMealById(mealId)),
      );

      final validMeals = meals.whereType<Meal>().toList();

      emit(MealsSuccess(MealResponse(meals: validMeals)));
      return validMeals;
    } catch (e, trace) {
      if (kDebugMode) {
        print(trace.toString());
      }
      emit(MealsError());
      return [];
    }
  }
}
