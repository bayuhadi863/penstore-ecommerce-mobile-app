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

  // fetch payment methods from payment_methods collection by userId
  Future<List<PaymentMethodModel>> fetchPaymentMethodsByUserId(
      String userId) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('paymentMethods')
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => PaymentMethodModel.fromSnapshot(doc))
          .toList();
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

  // fetch payment method by paymentMethodId
  Future<PaymentMethodModel> fetchPaymentMethodById(
      String paymentMethodId) async {
    try {
      final DocumentSnapshot doc =
          await db.collection('paymentMethods').doc(paymentMethodId).get();

      return PaymentMethodModel.fromSnapshot(doc);
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

  // delete payment method by paymentMethodId
  Future<void> deletePaymentMethod(String paymentMethodId) async {
    try {
      // get orders by paymentMethodId
      final QuerySnapshot querySnapshot = await db
          .collection('orders')
          .where('paymentMethodId', isEqualTo: paymentMethodId)
          .get();

      // if orders is not empty, throw error
      if (querySnapshot.docs.isNotEmpty) {
        throw 'Tidak bisa menghapus karena ada order yang menggunakan metode pembayaran ini';
      }

      await db.collection('paymentMethods').doc(paymentMethodId).delete();
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

  // update payment method by paymentMethodId
  Future<void> updatePaymentMethod(
      String paymentMethodId, String recipientName, String number) async {
    try {
      await db.collection('paymentMethods').doc(paymentMethodId).update({
        'recipientName': recipientName,
        'number': number,
      });
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
