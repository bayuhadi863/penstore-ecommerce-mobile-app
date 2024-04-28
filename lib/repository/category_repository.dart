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
      return querySnapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
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