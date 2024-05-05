import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/models/user_model.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Firestore create cart to carts collection by insert product and current user
  Future<void> createCart(
      UserModel user, ProductModel product, int quantity) async {
    try {
      final cart = CartModel(user: user, product: product, quantity: quantity);

      await db.collection('carts').add(cart.toJson(DateTime.now()));
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Firestore fetch cart by user id
  Future<List<CartModel>> fetchCart(String uid) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('carts')
          .where(
            'user.id',
            isEqualTo: uid,
          )
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs
          .map((doc) => CartModel.fromSnapshot(doc))
          .toList();

      // return querySnapshot.docs
      //     .map((doc) => CartModel.fromSnapshot(doc))
      //     .toList();
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Firestore delete cart by cart id
  Future<void> deleteCart(String id) async {
    try {
      await db.collection('carts').doc(id).delete();
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Subscribe for stream carts
  Stream<List<CartModel>> streamCarts(String uid) {
    return db
        .collection('carts')
        .where('user.id', isEqualTo: uid)
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => CartModel.fromSnapshot(doc)).toList());
  }

  // update quantity of cart
  Future<void> addCartQuantity(String id, int quantity) async {
    try {
      final DocumentSnapshot doc = await db.collection('carts').doc(id).get();

      final CartModel cart = CartModel.fromSnapshot(doc);

      // update quantity increment
      await db.collection('carts').doc(id).update({
        'quantity': cart.quantity + quantity,
      });
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // decrement quantity of cart
  Future<void> subtractCartQuantity(String id, int quantity) async {
    try {
      final DocumentSnapshot doc = await db.collection('carts').doc(id).get();

      final CartModel cart = CartModel.fromSnapshot(doc);

      // update quantity decrement
      await db.collection('carts').doc(id).update({
        'quantity': cart.quantity - quantity,
      });
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
