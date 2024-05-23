import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  String name;
  String desc;
  int stock;
  int price;
  String categoryId;
  DateTime? createdAt;
  String? userId;
  List<String>? imageUrl;

  ProductModel(
      {required this.id,
      required this.name,
      required this.desc,
      required this.stock,
      required this.price,
      required this.categoryId,
      required this.userId,
      required this.imageUrl,
      this.createdAt});

  static ProductModel empty() => ProductModel(
      id: '',
      name: '',
      desc: '',
      stock: 0,
      price: 0,
      categoryId: '',
      userId: '',
      imageUrl: [],
      createdAt: null);

  Map<String, dynamic> toJson(createdAt) {
    return {
      'name': name,
      'desc': desc,
      'price': price,
      'stock': stock,
      'categoryId': categoryId,
      'userId': userId,
      'imageUrl': imageUrl,
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
      userId: data['userId'],
      imageUrl: data['imageUrl'] is Iterable
          ? List<String>.from(data['imageUrl'])
          : [],
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
