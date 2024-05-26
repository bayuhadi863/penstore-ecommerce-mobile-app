import 'package:cloud_firestore/cloud_firestore.dart';

class BillPaymentModel {
  final String? id;
  final String userId;
  final int total;
  final String status;
  final String billId;
  final DateTime? createdAt;

  BillPaymentModel({
    this.id,
    required this.userId,
    required this.total,
    required this.status,
    required this.billId,
    this.createdAt,
  });

  static BillPaymentModel empty() => BillPaymentModel(
        id: '',
        userId: '',
        total: 0,
        status: '',
        billId: '',
        createdAt: null,
      );

  Map<String, dynamic> toJson(createdAt) {
    return {
      'userId': userId,
      'total': total,
      'status': status,
      'billId': billId,
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
      createdAt: data['createdAt']?.toDate(),
    );
  }
}
