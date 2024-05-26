import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/bill_payment.dart';

class BillPaymentRepository extends GetxController {
  static BillPaymentRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

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
}
