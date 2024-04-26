import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String name;
  String email;
  DateTime? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  static UserModel empty() =>
      UserModel(id: '', name: '', email: '', createdAt: null);

  Map<String, dynamic> toJson(createdAt) {
    return {
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }

  /// Factory method to create a UserModel from a DocumentSnapshot
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: documentSnapshot.id,
      name: data['name'],
      email: data['email'],
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
