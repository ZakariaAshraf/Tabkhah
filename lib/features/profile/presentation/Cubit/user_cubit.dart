import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUserData() async {
    try {
      emit(UserLoading());

      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      DocumentSnapshot doc = await userDocRef.get();

      if (doc.exists) {
       user = AppUser.fromFirestore(doc);
        emit(UserLoaded(user!));
      } else {
        emit(UserError("No user data found for the current user"));
      }
    } catch (e) {
      emit(UserError("Error retrieving user data: $e"));
    }
  }

  // Future<void> saveUserData({required String name, required String phone, File ?image,required String nationality}) async {
  //   try {
  //     emit(UserLoading());
  //     String userId = FirebaseAuth.instance.currentUser!.uid;
  //
  //     await FirebaseFirestore.instance.collection("users").doc(userId).set({
  //       'name': name,
  //       'phone': phone,
  //       'createdAt': FieldValue.serverTimestamp(),
  //       'nationality': nationality,
  //     });
  //
  //     emit(
  //       UserLoaded(
  //         AppUser(
  //           name: name,
  //           phone: phone,
  //           createdAt: DateTime.now(), nationality: nationality,
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     emit(UserError("Error saving user data: $e"));
  //   }
  // }

  AppUser? user;

  Future<void> updateProfile({
    String? fullName,
    String? phoneNumber,
    File? profilePicture,
  }) async {
    emit(UserLoading());
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("User not logged in");
      }

      String? photoUrl;
      if (profilePicture != null) {
        // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        // Reference reference =
        //     FirebaseStorage.instance.ref().child('user_photos/$fileName');
        // UploadTask uploadTask = reference.putFile(profilePicture);
        // TaskSnapshot taskSnapshot = await uploadTask;
        // photoUrl = await taskSnapshot.ref.getDownloadURL();
      }

      final Map<String, dynamic> updatedData = {
        if (fullName != null) 'name': fullName,
        if (phoneNumber != null) 'phone': phoneNumber,
      };

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(updatedData);

      user = AppUser(
        name: fullName ?? user?.name ?? '',
        phone: phoneNumber ?? user?.phone ?? '',
        photoUrl: photoUrl ?? user?.photoUrl ?? '',
        createdAt: user?.createdAt ?? DateTime.now(), nationality: '',
      );

      emit(UserSuccess());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
