import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit() : super(LikesInitial());

  StreamSubscription? _likesSubscription;

  void listenToLikes(String mealId) {
    _likesSubscription?.cancel();

    _likesSubscription = FirebaseFirestore.instance
        .collection("likes")
        .doc(mealId)
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists) {
        emit(LikesLoaded(count: 0, isLiked: false));
        return;
      }

      final data = snapshot.data()!;
      final count = data['count'] ?? 0;


      final isLiked = (data['likedBy'] ?? [])
          .contains(FirebaseAuth.instance.currentUser?.uid);

      emit(LikesLoaded(count: count, isLiked: isLiked));
    });
  }

  Future<void> toggleLike(String mealId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final docRef =
    FirebaseFirestore.instance.collection("likes").doc(mealId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        transaction.set(docRef, {
          'count': 1,
          'likedBy': [uid]
        });
        return;
      }

      final data = snapshot.data()!;
      final likedBy = List<String>.from(data['likedBy'] ?? []);
      int count = data['count'] ?? 0;

      if (likedBy.contains(uid)) {
        likedBy.remove(uid);
        count--;
      } else {
        likedBy.add(uid);
        count++;
      }

      transaction.update(docRef, {
        'count': count,
        'likedBy': likedBy,
      });
    });
  }

  @override
  Future<void> close() {
    _likesSubscription?.cancel();
    return super.close();
  }
}
