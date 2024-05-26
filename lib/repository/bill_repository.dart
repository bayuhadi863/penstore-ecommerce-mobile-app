import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/bill_model.dart';

class BillRepository extends GetxController {
  static BillRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // create new bill with parameter only userId and total
  Future<void> createBill(String userId, int total) async {
    try {
      await db.collection('bills').add({
        'userId': userId,
        'total': total,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
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

  // update bill with parameter only userId and total
  Future<void> updateBill(String userId, int total) async {
    try {
      final snapshot =
          await db.collection('bills').where('userId', isEqualTo: userId).get();
      if (snapshot.docs.isNotEmpty) {
        await db.collection('bills').doc(snapshot.docs.first.id).update({
          'total': total,
          'updatedAt': DateTime.now(),
        });
      } else {
        await createBill(userId, total);
      }
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

  // fetch bill by userId return single BillModel
  Future<BillModel> fetchBill(String userId) async {
    try {
      final snapshot =
          await db.collection('bills').where('userId', isEqualTo: userId).get();
      if (snapshot.docs.isNotEmpty) {
        return BillModel.fromSnapshot(snapshot.docs.first);
      } else {
        return BillModel.empty();
      }
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

  // increase total of bill by userId
  Future<void> increaseBill(String userId, int total) async {
    try {
      final snapshot =
          await db.collection('bills').where('userId', isEqualTo: userId).get();
      if (snapshot.docs.isNotEmpty) {
        await db.collection('bills').doc(snapshot.docs.first.id).update({
          'total': FieldValue.increment(total),
          'updatedAt': DateTime.now(),
        });
      } else {
        await createBill(userId, total);
      }
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

  // decrease total of bill by userId
  Future<void> decreaseBill(String userId, int total) async {
    try {
      final snapshot =
          await db.collection('bills').where('userId', isEqualTo: userId).get();
      if (snapshot.docs.isNotEmpty) {
        await db.collection('bills').doc(snapshot.docs.first.id).update({
          'total': FieldValue.increment(-total),
          'updatedAt': DateTime.now(),
        });
      } else {
        await createBill(userId, total);
      }
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
