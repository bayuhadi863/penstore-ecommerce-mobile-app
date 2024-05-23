import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/payment_method_model.dart';

class PaymentMethodRepository extends GetxController {
  static PaymentMethodRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Firestore create payment method to payment_methods collection with parameter Payment Method Model
  Future<void> createPaymentMethod(PaymentMethodModel paymentMethod) async {
    try {
      await db.collection('paymentMethods').add(paymentMethod.toJson());
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw e.toString();
    }
  }
}
