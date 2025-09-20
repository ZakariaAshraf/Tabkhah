import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../data/models/meal_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  final User? _user = FirebaseAuth.instance.currentUser;

  final Set<String> favoriteMealIds = {};

  bool isFavorite(String mealId) => favoriteMealIds.contains(mealId);

  Future<void> addToFavourite(Meal meal) async {
    if (_user == null) return;

    emit(FavouriteLoading());

    try {
      final favouritesCollectionRef = FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .collection("bookmarks");

      if (favoriteMealIds.contains(meal.idMeal)) {
        await favouritesCollectionRef.doc(meal.idMeal).delete();
        favoriteMealIds.remove(meal.idMeal);
      } else {
        await favouritesCollectionRef.doc(meal.idMeal).set(meal.toFirestore());
        favoriteMealIds.add(meal.idMeal);
      }

      emit(FavouriteUpdated());
    } catch (e) {
      emit(FavouriteError(e.toString()));
      if (kDebugMode) {
        print("Error saving data: $e");
      }
    }
  }

  Future<void> loadFavorites() async {
    if (_user == null) return;

    emit(FavouriteLoading());

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .collection("bookmarks")
          .get();



      favoriteMealIds.clear();
      favoriteMealIds.addAll(snapshot.docs.map((doc) => doc.id));

      // Convert snapshot documents into Meal objects
      final meals = snapshot.docs
          .map((doc) => Meal.fromJson(doc.data())) // Make sure fromFirestore exists
          .toList();
      emit(FavouriteSuccess(meals: meals));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
}
