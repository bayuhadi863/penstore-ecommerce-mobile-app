import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistModel {
  final String id;
  String name;
  List<String>? products;
  DateTime? createdAt;

  WishlistModel(
      {required this.id,
      required this.name,
      required this.products,
      this.createdAt});

  static WishlistModel empty() =>
      WishlistModel(id: '', name: '', products: [], createdAt: null);

  Map<String, dynamic> toJson(createdAt) {
    return {
      'id': id,
      'name': name,
      'productId': products,
      'createdAt': createdAt
    };
  }

  factory WishlistModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return WishlistModel(
      id: data['id'] as String,
      name: data['name'] as String,
      products: data['productId'] is Iterable
          ? List<String>.from(data['productId'])
          : [],
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
