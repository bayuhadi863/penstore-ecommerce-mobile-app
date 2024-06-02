import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/bill_payment.dart';

class BillPaymentRepository extends GetxController {
  static BillPaymentRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

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

  // upload image to firebase storage with parameter only File
  Future<String> uploadImage(
    File image,
  ) async {
    try {
      TaskSnapshot storageTaskSnapshot = await storage
          .ref()
          .child('bill_payments/${getRandomImageName()}.jpg')
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

  // delete image by url
  Future<void> deleteImage(String url) async {
    try {
      await storage.refFromURL(url).delete();
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

  // create new bill with parameter only BillPaymentModel
  Future<void> createBillPayment(BillPaymentModel billPayment) async {
    try {
      await db
          .collection('bill_payments')
          .add(billPayment.toJson(DateTime.now()));
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

  // fetch the latest bill payment by userId
  Future<BillPaymentModel> fetchBillPaymentByUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('bill_payments')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return BillPaymentModel.fromSnapshot(querySnapshot.docs.first);
      }
      return BillPaymentModel.empty();
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

  // fetch bill payments by userId
  Future<List<BillPaymentModel>> fetchBillPaymentsByUserId(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('bill_payments')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((e) => BillPaymentModel.fromSnapshot(e))
          .toList();
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

  // fetch all bill payments
  Future<List<BillPaymentModel>> fetchAllBillPayments() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('bill_payments').get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs
          .map((e) => BillPaymentModel.fromSnapshot(e))
          .toList();
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

  // fetch bill payment by id
  Future<BillPaymentModel> fetchBillPaymentById(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await db.collection('bill_payments').doc(id).get();

      if (!documentSnapshot.exists) {
        return BillPaymentModel.empty();
      }

      return BillPaymentModel.fromSnapshot(documentSnapshot);
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

  // update bill payment status by id
  Future<void> updateBillPaymentStatus(String id, String status) async {
    try {
      await db.collection('bill_payments').doc(id).update({'status': status});
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

  
}
