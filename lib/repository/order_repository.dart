import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/order_model.dart';
import 'package:penstore/repository/cart_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // create order with parameter OrderModel
  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      final docRef = await db.collection('orders').add(
            order.toJson(
              DateTime.now(),
            ),
          );
      final doc = await docRef.get();

      // get products from order.cartIds
      final cartRepository = Get.put(CartRepository());
      final carts = await cartRepository.fetchCartsByIds(order.cartIds);

      // remove product stock from product collection for each productIds
      for (final cart in carts) {
        final productDoc =
            await db.collection('products').doc(cart.product.id).get();
        final product = productDoc.data();
        final stock = product!['stock'] - cart.quantity;
        await db
            .collection('products')
            .doc(cart.product.id)
            .update({'stock': stock});
      }

      // update cart isOrdered to true
      for (final cart in carts) {
        await db.collection('carts').doc(cart.id).update({'isOrdered': true});
      }

      return OrderModel.fromSnapshot(doc);
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

  // fetch orders by userId
  Future<List<OrderModel>> fetchOrdersByUserId(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
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

  // fetch order by orderId
  Future<OrderModel> fetchOrderById(String orderId) async {
    try {
      final doc = await db.collection('orders').doc(orderId).get();
      return OrderModel.fromSnapshot(doc);
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

  // fetch orders by sellerId
  Future<List<OrderModel>> fetchOrdersBySellerId(String sellerId) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('orders')
          .where('sellerId', isEqualTo: sellerId)
          .get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
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

  // update order status by orderId
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await db.collection('orders').doc(orderId).update({'status': status});
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

  // update order isPaymentRejected by orderId
  Future<void> updateOrderPaymentRejected(
      String orderId, bool isPaymentRejected) async {
    try {
      await db.collection('orders').doc(orderId).update(
        {'isPaymentRejected': isPaymentRejected},
      );
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
