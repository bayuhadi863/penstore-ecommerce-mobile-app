import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPaymentMethodModel {
  final String? id;
  final String name;
  final String recipientName;
  final String number;

  AdminPaymentMethodModel({
    this.id,
    required this.name,
    required this.recipientName,
    required this.number,
  });

  static AdminPaymentMethodModel empty() => AdminPaymentMethodModel(
        id: '',
        name: '',
        recipientName: '',
        number: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'recipientName': recipientName,
      'number': number,
    };
  }

  // Factory methos to create a AdminPaymentMethodModel from a DocumentSnapshot
  factory AdminPaymentMethodModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return AdminPaymentMethodModel(
      id: documentSnapshot.id,
      name: data['name'],
      recipientName: data['recipientName'],
      number: data['number'],
    );
  }
}
