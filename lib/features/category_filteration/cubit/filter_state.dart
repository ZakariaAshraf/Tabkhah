part of 'filter_cubit.dart';

@immutable
sealed class FilterState {}

final class FilterInitial extends FilterState {}
final class FilterLoading extends FilterState {}
final class FilterSuccess extends FilterState {
final List<Meal> meals;
FilterSuccess(this.meals);

}
final class FilterError extends FilterState {
  final String error;
  FilterError(this.error);
}
