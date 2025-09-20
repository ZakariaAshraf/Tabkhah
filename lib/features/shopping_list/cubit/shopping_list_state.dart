part of 'shopping_list_cubit.dart';

@immutable
sealed class ShoppingListState {}

final class ShoppingListInitial extends ShoppingListState {}
class ShoppingListLoading extends ShoppingListState {}

class ShoppingListUpdated extends ShoppingListState {
  final List<ShoppingListItem> items;
  ShoppingListUpdated(this.items);
}

class ShoppingListSavedSuccessfully extends ShoppingListState {}

class ShoppingListError extends ShoppingListState {
  final String message;
  ShoppingListError(this.message);
}