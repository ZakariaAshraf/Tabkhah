import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/auth_usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({required this.signInUseCase, required this.registerUseCase})
      : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase.execute(email, password);

      emit(AuthSuccess(user: user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> saveUserData({
    required String name,
    required String phone,
     String? nationality,
  }) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        'name': name,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
        'nationality': nationality ?? "EGY",
      });
    } catch (e) {
      emit(AuthFailure("Error saving user data: $e"));
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String phone,
      String? nationality,
      required String name}) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase.execute(email, password);
       await saveUserData(name: name, phone: phone, nationality: nationality);
      emit(AuthSuccess(user: user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void signOut() {
    emit(AuthInitial());
  }
}
