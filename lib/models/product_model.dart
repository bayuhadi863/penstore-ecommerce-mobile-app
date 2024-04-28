import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  String name;
  String desc;
  int stock;
  int price;
  String categoryId;
  DateTime? createdAt;
  
  ProductModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.stock,
    required this.price,
    required this.categoryId,
    this.createdAt
  });

  static ProductModel empty() => 
    ProductModel(id: '', name: '', desc: '', stock: 0, price: 0, categoryId: '', createdAt: null);
  

  Map<String, dynamic> toJson(createdAt) {
    return {
      'name': name,
      'desc' : desc,
      'price': price,
      'stock': stock,
      'categoryId': categoryId,
      'createdAt': createdAt
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel(
      id: snapshot.id,
      name: data['name'],
      desc: data['desc'],
      stock: data['stock'],
      price: data['price'],
      categoryId: data['categoryId'],
      createdAt: data['createdAt']?.toDate(),
    );
  }
}