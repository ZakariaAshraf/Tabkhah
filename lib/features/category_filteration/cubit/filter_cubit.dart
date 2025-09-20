import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/meal_model.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  Future<void> filterByCategory(String category) async {
    emit(FilterLoading());

    try {
      final response = await http.get(
          Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category')
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final mealsData = jsonResponse['meals'] as List?;

        if (mealsData == null) {
          emit(FilterSuccess(const []));
          return;
        }

        final meals = mealsData.map((meal) => Meal.fromJson(meal)).toList();
        emit(FilterSuccess(meals));
      } else {
        emit(FilterError('Failed to load meals. Status: ${response.statusCode}'));
      }
    } catch (e) {
      emit(FilterError('Failed to load meals: ${e.toString()}'));
    }
  }
}