import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPaymentModel {
  String? id;
  final String orderId;
  final String imageUrl;
  final DateTime? createdAt;

  OrderPaymentModel({
    this.id,
    required this.orderId,
    required this.imageUrl,
    this.createdAt,
  });

  static OrderPaymentModel empty() => OrderPaymentModel(
        id: '',
        orderId: '',
        imageUrl: '',
        createdAt: null,
      );

  Map<String, dynamic> toJson(createdAt) {
    return {
      'orderId': orderId,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  factory OrderPaymentModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return OrderPaymentModel(
      id: documentSnapshot.id,
      orderId: data['orderId'],
      imageUrl: data['imageUrl'],
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
