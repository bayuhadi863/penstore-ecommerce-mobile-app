import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  final String? id;
  final String userId;
  final int total;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BillModel({
    this.id,
    required this.userId,
    required this.total,
    this.createdAt,
    this.updatedAt,
  });

  static BillModel empty() => BillModel(
        id: '',
        userId: '',
        total: 0,
        createdAt: null,
        updatedAt: null,
      );

  Map<String, dynamic> toJson(createdAt, updatedAt) {
    return {
      'userId': userId,
      'total': total,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Factory methos to create a OrderModel from a DocumentSnapshot
  factory BillModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return BillModel(
      id: documentSnapshot.id,
      userId: data['userId'],
      total: data['total'],
      createdAt: data['createdAt']?.toDate(),
      updatedAt: data['updatedAt']?.toDate(),
    );
  }
}
