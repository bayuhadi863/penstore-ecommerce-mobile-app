import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/order_payment_model.dart';

class OrderPaymentRepository extends GetxController {
  static OrderPaymentRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> addOrderPayment(OrderPaymentModel orderPayment) async {
    try {
      await db.collection('order_payments').add(
            orderPayment.toJson(
              DateTime.now(),
            ),
          );

      // update order status to 'waiting'
      await db.collection('orders').doc(orderPayment.orderId).update({
        'status': 'waiting',
      });
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exception error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // get random name for image
  String getRandomImageName() {
    int milliseconds = DateTime.now().millisecondsSinceEpoch;
    Random random = Random(milliseconds);
    String randomString = '';
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    for (int i = 0; i < 10; i++) {
      randomString += chars[random.nextInt(chars.length)];
    }
    return randomString;
  }

  // upload order payment image with parameter only File
  Future<String> uploadImage(
    File image,
  ) async {
    try {
      TaskSnapshot storageTaskSnapshot = await storage
          .ref()
          .child('order_payments/${getRandomImageName()}.jpg')
          .putFile(image);
      String url = await storageTaskSnapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exception error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // fetch order payment by orderId
  Future<OrderPaymentModel> fetchOrderPaymentByOrderId(String orderId) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('order_payments')
          .where('orderId', isEqualTo: orderId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return OrderPaymentModel.fromSnapshot(querySnapshot.docs.first);
      } else {
        return OrderPaymentModel.empty();
      }
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exception error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw e.toString();
    }
  }
}
