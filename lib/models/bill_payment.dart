import 'package:cloud_firestore/cloud_firestore.dart';

class BillPaymentModel {
  final String? id;
  final String userId;
  final int total;
  final String status;
  final String billId;
  final String imageUrl;
  final String adminPaymentMethodId;
  final DateTime? createdAt;

  BillPaymentModel({
    this.id,
    required this.userId,
    required this.total,
    required this.status,
    required this.billId,
    required this.imageUrl,
    required this.adminPaymentMethodId,
    this.createdAt,
  });

  static BillPaymentModel empty() => BillPaymentModel(
        id: '',
        userId: '',
        total: 0,
        status: '',
        billId: '',
        imageUrl: '',
        adminPaymentMethodId: '',
        createdAt: null,
      );

  Map<String, dynamic> toJson(createdAt) {
    return {
      'userId': userId,
      'total': total,
      'status': status,
      'billId': billId,
      'imageUrl': imageUrl,
      'adminPaymentMethodId': adminPaymentMethodId,
      'createdAt': createdAt,
    };
  }

  factory BillPaymentModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return BillPaymentModel(
      id: documentSnapshot.id,
      userId: data['userId'],
      total: data['total'],
      status: data['status'],
      billId: data['billId'],
      imageUrl: data['imageUrl'],
      adminPaymentMethodId: data['adminPaymentMethodId'],
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
