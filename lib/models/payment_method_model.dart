import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethodModel {
  final String? id;
  final String userId;
  final String name;
  final String recipientName;
  final String number;

  PaymentMethodModel({
    this.id,
    required this.userId,
    required this.name,
    required this.recipientName,
    required this.number,
  });

  static PaymentMethodModel empty() => PaymentMethodModel(
        id: '',
        userId: '',
        name: '',
        recipientName: '',
        number: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'recipientName': recipientName,
      'number': number,
    };
  }

  // Factory methos to create a PaymentMethodModel from a DocumentSnapshot
  factory PaymentMethodModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return PaymentMethodModel(
      id: documentSnapshot.id,
      userId: data['userId'],
      name: data['name'],
      recipientName: data['recipientName'],
      number: data['number'],
    );
  }
}
