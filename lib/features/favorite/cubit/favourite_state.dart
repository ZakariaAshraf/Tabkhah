part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}
class FavouriteLoading extends FavouriteState {}

class FavouriteUpdated extends FavouriteState {}
class FavouriteSuccess extends FavouriteState {
 final List<Meal>meals;

  FavouriteSuccess({required this.meals});
}

class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError(this.message);
}
