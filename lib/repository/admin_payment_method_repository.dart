import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/admin_payment_method_model.dart';

class AdminPaymentMethodRepository extends GetxController {
  static AdminPaymentMethodRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // create new admin payment method with parameter only AdminPaymentMethodModel
  Future<void> createAdminPaymentMethod(
      AdminPaymentMethodModel adminPaymentMethod) async {
    try {
      await db
          .collection('adminPaymentMethods')
          .add(adminPaymentMethod.toJson());
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

  // fetch all admin payment methods
  Future<List<AdminPaymentMethodModel>> fetchAdminPaymentMethods() async {
    try {
      final snapshot = await db.collection('adminPaymentMethods').get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => AdminPaymentMethodModel.fromSnapshot(doc))
            .toList();
      } else {
        return [];
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
