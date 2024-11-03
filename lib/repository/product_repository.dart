import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // tambah produk
  Future<void> addProduct(String name, String desc, int stock, int price,
      List<String> imgUrls, String categoryId, String userId) async {
    try {
      await db.collection('products').add({
        "name": name,
        "desc": desc,
        "stock": stock,
        "imageUrl":
            imgUrls, // Menggunakan field imageUrls untuk menyimpan array URL gambar
        "price": price,
        "categoryId": categoryId,
        "createdAt": FieldValue.serverTimestamp(),
        "userId": userId,
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
    return '$randomString';
  }

// upload image produk
  Future<String> uploadImage(
    File image,
  ) async {
    try {
      TaskSnapshot storageTaskSnapshot = await storage
          .ref()
          .child('products/${getRandomImageName()}.jpg')
          .putFile(image);

      // ambil public url dari storage
      print("mencoba mengambil image url...");
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      print("downloadUrl $downloadUrl");
      return downloadUrl;
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

// get all data product
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final QuerySnapshot<Map<dynamic, dynamic>> querySnapshot = await db
          .collection('products')
          // .where('stock', isGreaterThan: 0)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        print("dataku ${querySnapshot.docs}");
        return querySnapshot.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
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
      throw 'Something went wrong. Please try again $e';
    }
  }

// get specifi product by categoryId
  Future<List<ProductModel>> getProductsByCategoryId(String categoryId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('products')
          // .where('stock', isGreaterThan: 1)
          .where('categoryId', isEqualTo: categoryId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
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
      throw 'Something went wrong. Please try again';
    }
  }

  // // get product by id
  Future<ProductModel> getProductById(String productId) async {
    try {
      final DocumentSnapshot documentSnapshot =
          await db.collection('products').doc(productId).get();

      if (documentSnapshot.exists) {
        return ProductModel.fromSnapshot(documentSnapshot);
      } else {
        throw ProductModel.empty();
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

  // get product by user id
  Future<List<ProductModel>> getProductsByUserId(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('products')
          .where('userId', isEqualTo: userId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
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
      throw 'Something went wrong. Please try again';
    }
  }

  // search product by name
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          // .where('stock', isGreaterThan: 0)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
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
      throw 'Something went wrong. Please try again';
    }
  }

  // update product
  Future<void> updateProduct(ProductModel product) async {
    try {
      await db.collection('products').doc(product.id).update({
        "name": product.name,
        "desc": product.desc,
        "stock": product.stock,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "categoryId": product.categoryId,
      });
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // set stock zero
  Future<void> setStockZero(String productId) async {
    try {
      await db.collection('products').doc(productId).update({
        "stock": 0,
      });
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format exeption error';
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }
}
