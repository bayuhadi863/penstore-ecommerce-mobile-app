import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/rating_model.dart';

class RatingRepository extends GetxController {
  static RatingRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Firestore create rating to ratings collection with parameter Rating Model
  Future<void> createRating(RatingModel rating) async {
    try {
      await db.collection('ratings').add(rating.toJson(DateTime.now()));
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

  // fetch ratings list by orderId
  Future<List<RatingModel>> fetchRatingsByOrderId(String orderId) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('ratings')
          .where('orderId', isEqualTo: orderId)
          .get();

      // check if the querySnapshot.docs is empty
      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs
          .map((doc) => RatingModel.fromSnapshot(doc))
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

  // fetch rating by orderId and productId
  Future<RatingModel> fetchRatingByOrderIdAndProductId(
      String orderId, String productId) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('ratings')
          .where('orderId', isEqualTo: orderId)
          .where('productId', isEqualTo: productId)
          .get();

      // check if the querySnapshot.docs is empty
      if (querySnapshot.docs.isEmpty) {
        return RatingModel.empty();
      }

      return RatingModel.fromSnapshot(querySnapshot.docs.first);
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

  // check if there is rating by orderId and productId
  Future<bool> isRatingExist(String orderId, String productId) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('ratings')
          .where('orderId', isEqualTo: orderId)
          .where('productId', isEqualTo: productId)
          .get();

      return querySnapshot.docs.isNotEmpty;
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
