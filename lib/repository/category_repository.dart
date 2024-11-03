import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // get all category
  Future<List<CategoryModel>> getCategories() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection('categories').get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) => CategoryModel.fromSnapshot(doc))
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

  // ambil category berdasarkan id
  Future<CategoryModel> getCategoryById(String id) async {
    try {
      final DocumentSnapshot documentSnapshot =
          await db.collection('categories').doc(id).get();

      if (documentSnapshot.exists) {
        return CategoryModel.fromSnapshot(documentSnapshot);
      } else {
        throw CategoryModel.empty();
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

  // create category
  Future<void> createCategory(CategoryModel category) async {
    try {
      await db.collection('categories').add(category.toJson());
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

  // delete category
  Future<void> deleteCategory(String id) async {
    try {
      // get products by categoryId
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('products')
          .where('categoryId', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw 'Kategori ini masih digunakan dalam produk.';
      }

      await db.collection('categories').doc(id).delete();
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

  // edit category with parameter id and category_name
  Future<void> editCategory(String id, String categoryName) async {
    try {
      await db.collection('categories').doc(id).update({
        'category_name': categoryName,
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
