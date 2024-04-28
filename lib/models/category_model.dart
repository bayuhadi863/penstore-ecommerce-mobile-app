import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final id;
  String category_name;

  CategoryModel({
    required this.id,
    required this.category_name,
  });

  static CategoryModel empty() => CategoryModel(id: "", category_name: "");

  Map<String, dynamic> toJson(createdAt) {
    return {
      'category_name': category_name,
    };
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: documentSnapshot.id,
      category_name: data['category_name'],
    );
  }
}
