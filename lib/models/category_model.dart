import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? id;
  String category_name;

  CategoryModel({
    this.id,
    required this.category_name,
  });

  static CategoryModel empty() => CategoryModel(id: "", category_name: "");

  Map<String, dynamic> toJson() {
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
