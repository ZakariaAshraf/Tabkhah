import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String name;
  final String phone;
  final DateTime createdAt;
  final String ?photoUrl;
  final String nationality;

  AppUser({
    required this.name,
    required this.phone,
    required this.createdAt,
     this.photoUrl,
    required this.nationality,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AppUser(
      name: data['name'],
      phone: data['phone'],
      createdAt: data['createdAt'].toDate(),
      photoUrl: data['photoUrl'], nationality: data['nationality'],
    );
  }
}