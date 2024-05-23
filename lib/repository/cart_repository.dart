import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Firestore create cart to carts collection by insert product and current user
  Future<void> createCart(
      UserModel user, ProductModel product, int quantity) async {
    try {
      // get product by product.id
      final productRepository = Get.put(ProductRepository());
      final ProductModel productData =
          await productRepository.getProductById(product.id);

      final cart = CartModel(user: user, product: product, quantity: quantity);

      // check if cart already exist then update quantity
      final QuerySnapshot querySnapshot = await db
          .collection('carts')
          .where('user.id', isEqualTo: user.id)
          .where('product.id', isEqualTo: product.id)
          .where('isOrdered', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final CartModel cart = CartModel.fromSnapshot(querySnapshot.docs.first);

        // check if current quantity plus new quantity is greater product stock then throw error
        if (cart.quantity + quantity > productData.stock) {
          // Alerts.errorSnackBar(
          //     title: 'Gagal menambah keranjang!',
          //     message: "Kuantitas yang Anda masukkan melebihi stok!");
          throw 'Kuantitas yang Anda masukkan melebihi stok';
          // return;
        }

        // update quantity increment
        await db.collection('carts').doc(cart.id).update({
          'quantity': cart.quantity + quantity,
        });

        return;
      }
      // if cart not exist then create new cart
      await db.collection('carts').add(cart.toJson(DateTime.now()));
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

      // check if current quantity plus new quantity is greater product stock then throw error
      if (cart.quantity + quantity > cart.product.stock) {
        throw 'Kuantitas yang Anda masukkan melebihi stok';
      }

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

      // check if current quantity minus new quantity is less than 1 then throw error
      if (cart.quantity - quantity < 1) {
        throw 'Kuantitas minimal adalah 1';
      }

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

  // chect id cart already exist by user id and product id
  Future<bool> checkCartExist(String uid, String pid) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('carts')
          .where('user.id', isEqualTo: uid)
          .where('product.id', isEqualTo: pid)
          .get();

      return querySnapshot.docs.isNotEmpty;
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

  // fetch cart by cart id
  Future<CartModel> fetchCartById(String id) async {
    try {
      final DocumentSnapshot documentSnapshot =
          await db.collection('carts').doc(id).get();

      if (documentSnapshot.exists) {
        return CartModel.fromSnapshot(documentSnapshot);
      } else {
        throw CartModel.empty();
      }
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

  // fetch cart by cart ids
  Future<List<CartModel>> fetchCartsByIds(List<String> ids) async {
    try {
      final List<CartModel> carts = [];

      for (final id in ids) {
        final DocumentSnapshot documentSnapshot =
            await db.collection('carts').doc(id).get();

        if (documentSnapshot.exists) {
          carts.add(CartModel.fromSnapshot(documentSnapshot));
        }
      }

      return carts;
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

  // fetch carts by user id, get the carts.product.user.id distinct value
  Future<List<String>> fetchDistinctSellerId(String uid) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('carts')
          .where('user.id', isEqualTo: uid)
          .where('isOrdered', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      final List<String> sellerIds = querySnapshot.docs
          .map((doc) => CartModel.fromSnapshot(doc).product.userId!)
          .toSet()
          .toList();

      return sellerIds;
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

  // fetch carts by user id and seller id
  Future<List<CartModel>> fetchCartBySellerId(
      String uid, String sellerId) async {
    try {
      final QuerySnapshot querySnapshot = await db
          .collection('carts')
          .where('user.id', isEqualTo: uid)
          .where('product.userId', isEqualTo: sellerId)
          .where('isOrdered', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs
          .map((doc) => CartModel.fromSnapshot(doc))
          .toList();
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

  // Subscribe for stream carts by user id and seller id
  Stream<List<CartModel>> streamCartsBySellerId(String uid, String sellerId) {
    return db
        .collection('carts')
        .where('user.id', isEqualTo: uid)
        .where('product.userId', isEqualTo: sellerId)
        .where('isOrdered', isEqualTo: false)
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => CartModel.fromSnapshot(doc)).toList());
  }
}
