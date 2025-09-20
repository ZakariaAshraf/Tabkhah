part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Meal> meals;

  SearchSuccess(this.meals);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}