class Meal {
  final String idMeal;
  final String strMeal;
  final String? strMealAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<Ingredient> ingredients;
  final String? strSource;
  final String? strImageSource;
  final String? strCreativeCommonsConfirmed;
  final String? dateModified;

  Meal({
    required this.idMeal,
    required this.strMeal,
    this.strMealAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required this.ingredients,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty &&
          measure != null && measure.isNotEmpty) {
        ingredients.add(Ingredient(
          name: ingredient,
          measure: measure,
        ));
      }
    }

    return Meal(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealAlternate: json['strMealAlternate'],
      strCategory: json['strCategory'] ?? '',
      strArea: json['strArea'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? 'https://placehold.com/300x300',
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
      strSource: json['strSource'],
      strImageSource: json['strImageSource'],
      strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],
      dateModified: json['dateModified'],
    );
  }

  Map<String, dynamic> toJson() {
    // Convert ingredients back to the original format
    Map<String, dynamic> json = {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealAlternate': strMealAlternate,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strTags': strTags,
      'strYoutube': strYoutube,
      'strSource': strSource,
      'strImageSource': strImageSource,
      'strCreativeCommonsConfirmed': strCreativeCommonsConfirmed,
      'dateModified': dateModified,
    };

    // Add ingredients and measures
    for (int i = 0; i < ingredients.length; i++) {
      if (i < 20) { // Only up to 20 ingredients as per the API
        json['strIngredient${i + 1}'] = ingredients[i].name;
        json['strMeasure${i + 1}'] = ingredients[i].measure;
      }
    }

    // Fill remaining ingredient slots with empty strings
    for (int i = ingredients.length; i < 20; i++) {
      json['strIngredient${i + 1}'] = '';
      json['strMeasure${i + 1}'] = '';
    }

    return json;
  }
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> json = {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
    };


    return json;
  }
}

class Ingredient {
  final String name;
  final String measure;

  Ingredient({
    required this.name,
    required this.measure,
  });
}

class MealResponse {
  final List<Meal> meals;

  MealResponse({required this.meals});

  factory MealResponse.fromJson(Map<String, dynamic> json) {
    var mealsList = json['meals'] as List;
    List<Meal> meals = mealsList.map((mealJson) => Meal.fromJson(mealJson)).toList();

    return MealResponse(meals: meals);
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}