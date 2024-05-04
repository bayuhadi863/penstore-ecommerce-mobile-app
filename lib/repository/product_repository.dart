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
  Future<void> addProduct(
      String name, String desc, int stock, int price, String imgUrl ,String categoryId) async {
    try {
      await db.collection('products').add({
        "name": name,
        "desc": desc,
        "stock": stock,
        "imageUrl": imgUrl,
        "price": price,
        "categoryId": categoryId,
        "createdAt": FieldValue.serverTimestamp(),
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
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection('products').get();
      if (querySnapshot.docs.isNotEmpty) {
        print("dataku $querySnapshot.docs");
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
}
