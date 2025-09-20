part of 'likes_cubit.dart';

@immutable
sealed class LikesState {}

final class LikesInitial extends LikesState {}
class LikesLoaded extends LikesState {
  final int count;
  final bool isLiked;

  LikesLoaded({required this.count, required this.isLiked});
}