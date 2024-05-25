import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String? id;
  final String productId;
  final String userId;
  final String orderId;
  final int score;
  final String description;
  final DateTime? createdAt;

  RatingModel({
    this.id,
    required this.productId,
    required this.userId,
    required this.orderId,
    required this.score,
    required this.description,
    this.createdAt,
  });

  static RatingModel empty() => RatingModel(
        id: '',
        productId: '',
        userId: '',
        orderId: '',
        score: 0,
        description: '',
        createdAt: null,
      );

  Map<String, dynamic> toJson(DateTime createdAt) {
    return {
      'productId': productId,
      'userId': userId,
      'orderId': orderId,
      'score': score,
      'description': description,
      'createdAt': createdAt,
    };
  }

  // Factory methos to create a RatingModel from a DocumentSnapshot
  factory RatingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return RatingModel(
      id: documentSnapshot.id,
      productId: data['productId'],
      userId: data['userId'],
      orderId: data['orderId'],
      score: data['score'],
      description: data['description'],
      createdAt: data['createdAt'].toDate(),
    );
  }
}
