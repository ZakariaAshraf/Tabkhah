import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tab5ah/features/shopping_list/data/shopping_list_item_model.dart';

import '../../../data/models/meal_model.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  ShoppingListCubit() : super(ShoppingListInitial());

  final User? _user = FirebaseAuth.instance.currentUser;

  final List<ShoppingListItem> _shoppingList = [];

  List<ShoppingListItem> get shoppingList => List.unmodifiable(_shoppingList);

  Future<void> addToList(List<Ingredient> mealIngredients) async {
    if (_user == null) return;

    for (var ingredient in mealIngredients) {
      final index = _shoppingList.indexWhere(
          (item) => item.name.toLowerCase() == ingredient.name.toLowerCase());

      if (index != -1) {
        continue;
      } else {
        _shoppingList.add(
          ShoppingListItem(
            name: ingredient.name,
            measure: ingredient.measure,
          ),
        );
      }
    }
    emit(ShoppingListUpdated(List.from(_shoppingList)));
  }

  Future<void> saveDataToFirestore() async {
    if (_user == null) return;

    try {
      final ingredientsCollectionRef = FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .collection("shoppingList");

      final futures = shoppingList.map((item) {
        return ingredientsCollectionRef.doc(item.name).set(item.toMap());
      }).toList();

      await Future.wait(futures); // Ensures all writes complete

      emit(ShoppingListSavedSuccessfully());
    } catch (e) {
      emit(ShoppingListError("Failed to save: $e"));
    }
  }

  Future<void> loadShoppingList() async {
    if (_user == null) return;

    emit(ShoppingListLoading());

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .collection("shoppingList")
          .get();

      _shoppingList.clear();
      for (var doc in snapshot.docs) {
        _shoppingList.add(ShoppingListItem.fromMap(doc.data()));
      }
      if (shoppingList.isEmpty) {
        emit(ShoppingListInitial()); // <-- If empty after loading
      } else {
        emit(ShoppingListUpdated(List.from(shoppingList)));
      }
    } catch (e) {
      emit(ShoppingListError("Failed to load: $e"));
    }
  }

  void toggleItemCheck(String name) {
    final index = _shoppingList.indexWhere((item) => item.name == name);
    if (index != -1) {
      _shoppingList[index].isChecked = !_shoppingList[index].isChecked;
      emit(ShoppingListUpdated(List.from(_shoppingList)));
    }
  }

  void removeItem(String name) {
    _shoppingList.removeWhere((item) => item.name == name);
    emit(ShoppingListUpdated(List.from(_shoppingList)));
  }

  void addItem(String name, String measure) {
    final item = ShoppingListItem(name: name, measure: measure);

    _shoppingList.add(item);
    emit(ShoppingListUpdated(List.from(_shoppingList)));
  }

  Future<void> clearShoppingList() async {
    if (_user == null) return;

    try {
      final collection = FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .collection("shoppingList");

      final snapshot = await collection.get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      _shoppingList.clear();
      emit(ShoppingListInitial());
    } catch (e) {
      emit(ShoppingListError("Failed to clear list: $e"));
    }
  }
}
