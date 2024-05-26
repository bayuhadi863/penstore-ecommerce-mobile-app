import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final String userId;
  final String sellerId;
  final List<String> cartIds;
  final int totalProductPrice;
  final int serviceFee;
  final int totalPrice;
  final String paymentMethodId;
  final String status;
  final bool isPaymentRejected;
  final DateTime? createdAt;

  OrderModel({
    this.id,
    required this.userId,
    required this.sellerId,
    required this.cartIds,
    required this.totalProductPrice,
    required this.serviceFee,
    required this.totalPrice,
    required this.paymentMethodId,
    required this.status,
    this.isPaymentRejected = false,
    this.createdAt,
  });

  static OrderModel empty() => OrderModel(
        id: '',
        userId: '',
        sellerId: '',
        cartIds: [],
        totalProductPrice: 0,
        serviceFee: 0,
        totalPrice: 0,
        paymentMethodId: '',
        status: '',
        isPaymentRejected: false,
        createdAt: null,
      );

  Map<String, dynamic> toJson(createdAt) {
    return {
      'userId': userId,
      'sellerId': sellerId,
      'cartIds': cartIds,
      'totalProductPrice': totalProductPrice,
      'serviceFee': serviceFee,
      'totalPrice': totalPrice,
      'paymentMethodId': paymentMethodId,
      'status': status,
      'isPaymentRejected': isPaymentRejected,
      'createdAt': createdAt,
    };
  }

  // Factory methos to create a OrderModel from a DocumentSnapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: documentSnapshot.id,
      userId: data['userId'],
      sellerId: data['sellerId'],
      cartIds: List<String>.from(data['cartIds']),
      totalProductPrice: data['totalProductPrice'],
      serviceFee: data['serviceFee'],
      totalPrice: data['totalPrice'],
      paymentMethodId: data['paymentMethodId'],
      status: data['status'],
      isPaymentRejected: data['isPaymentRejected'],
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
