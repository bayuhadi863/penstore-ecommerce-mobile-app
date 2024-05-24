import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/models/user_model.dart';

class CartModel {
  final String? id;
  UserModel user;
  ProductModel product;
  int quantity;
  bool isOrdered;
  DateTime? createdAt;

  CartModel({
    this.id,
    required this.user,
    required this.product,
    required this.quantity,
    this.isOrdered = false,
    this.createdAt,
  });

  static CartModel empty() => CartModel(
        id: '',
        user: UserModel.empty(),
        product: ProductModel.empty(),
        quantity: 0,
        isOrdered: false,
        createdAt: null,
      );

  Map<String, dynamic> toJson(createdAt) {
    return {
      'user': {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'createdAt': user.createdAt,
      },
      'product': {
        'id': product.id,
        'name': product.name,
        'desc': product.desc,
        'price': product.price,
        'stock': product.stock,
        'categoryId': product.categoryId,
        'userId': product.userId,
        'imageUrl': product.imageUrl,
        'createdAt': product.createdAt,
      },
      'quantity': quantity,
      'isOrdered': isOrdered,
      'createdAt': createdAt,
    };
  }

  // Factory methos to create a CartModel from a DocumentSnapshot
  factory CartModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return CartModel(
      id: documentSnapshot.id,
      user: data['user'] != null
          ? UserModel(
              id: data['user']['id'],
              name: data['user']['name'],
              email: data['user']['email'],
              createdAt: data['user']['createdAt']?.toDate(),
            )
          : UserModel.empty(),
      product: data['product'] != null
          ? ProductModel(
              id: data['product']['id'],
              name: data['product']['name'],
              desc: data['product']['desc'],
              price: data['product']['price'],
              stock: data['product']['stock'],
              categoryId: data['product']['categoryId'],
              userId: data['product']['userId'],
              imageUrl: data['product']['imageUrl'] is Iterable
                  ? List<String>.from(data['product']['imageUrl'])
                  : [],
              createdAt: data['product']['createdAt']?.toDate(),
            )
          : ProductModel.empty(),
      quantity: data['quantity'],
      isOrdered: data['isOrdered'],
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
