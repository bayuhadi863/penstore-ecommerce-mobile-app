import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // tambah produk
  Future<void> addProduct(String name, String desc, int stock,
      int price, String categoryId) async {
    try {
      await db.collection('products').add({
        "name": name,
        "desc": desc,
        "stock": stock,
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

// get all data product
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection('products').get();
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
