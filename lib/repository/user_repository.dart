import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Firestore create user to users collection
  Future<void> createUser(String uid, String name, String email) async {
    try {
      await db.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        // 'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
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

  // Firestore fetch user by user id
  Future<UserModel> fetchUser(String uid) async {
    try {
      final DocumentSnapshot documentSnapshot =
          await db.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        throw UserModel.empty();
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
