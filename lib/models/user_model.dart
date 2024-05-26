import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String name;
  String email;
  String? phone;
  String? imageUrl;
  bool? isAdmin;
  DateTime? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.imageUrl = '',
    this.isAdmin = false,
    this.createdAt,
  });

  static UserModel empty() => UserModel(
        id: '',
        name: '',
        email: '',
        phone: '',
        imageUrl: '',
        isAdmin: false,
        createdAt: null,
      );

  Map<String, dynamic> toJson(createdAt) {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
      'isAdmin': isAdmin,
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
      phone: data['phone'] ?? '',
      imageUrl: data['imageUrl'],
      isAdmin: data['isAdmin'] ?? false,
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
