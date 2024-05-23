import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:penstore/models/wishlist_model.dart';

class WishlistRepository extends GetxController {
  static WishlistRepository get to => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // create wishlist
  Future<String> createWishlist(String wishlistName, String userId) async {
    try {
      DocumentReference docRef = await db.collection('wishlists').add({
        'name': wishlistName,
        'productId': [],
        'userId': userId,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return docRef.id;
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

  // get all wishlist
  Future<List<WishlistModel>> getUserWishlist(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('wishlists')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => WishlistModel.fromSnapshot(doc))
            .toList();
      } else {
        return [];
      }
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e}';
    }
  }

  // check if product is already in wishlist
  Future<bool> isProductInWishlist(String productId, String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('wishlists')
          .where('userId', isEqualTo: userId)
          .get();

      // cek iterasi setiap dok wishlist
      for (var doc in querySnapshot.docs) {
        List<dynamic> productIds = doc.data()['productId'];
        if (productIds.contains(productId)) {
          return true;
        }
      }
      return false;
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

  // get all products in wishlist
  Future<List<ProductModel>> getWishlistProduct(String wishlistId) async {
    try {
      // Ambil dokumen wishlist berdasarkan wishlistId
      final DocumentSnapshot<Map<String, dynamic>> wishlistSnapshot =
          await db.collection('wishlists').doc(wishlistId).get();

      if (!wishlistSnapshot.exists) {
        return [];
      }

      // Ambil daftar productId dari dokumen wishlist
      final List<dynamic> productIds =
          wishlistSnapshot.data()?['productId'] ?? [];

      if (productIds.isEmpty) {
        return [];
      }

      // Ambil detail setiap produk berdasarkan productId
      List<ProductModel> products = [];
      for (String productId in productIds) {
        final DocumentSnapshot<Map<String, dynamic>> productSnapshot =
            await db.collection('products').doc(productId).get();

        if (productSnapshot.exists) {
          products.add(ProductModel.fromSnapshot(productSnapshot));
        }
      }

      return products;
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

  // add product to wishlist
  Future<void> addToWishlist(String wishlistId, String productId) async {
    try {
      await db.collection('wishlists').doc(wishlistId).set({
        'productId': FieldValue.arrayUnion([productId]),
      }, SetOptions(merge: true));
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

  // delete wishlist
  Future<void> deleteWishlist(String wishlistId) async {
    try {
      await db.collection('wishlists').doc(wishlistId).delete();
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
