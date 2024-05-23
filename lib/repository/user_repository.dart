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
        // print(UserModel.fromSnapshot(documentSnapshot));
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        // print('error');
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

  // fetch users collection retur Map string any
  Future<Map<String, dynamic>> fetchUsers() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection('users').get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> user) =>
                MapEntry<String, dynamic>(user.id, user.data()))
            .fold<Map<String, dynamic>>(
                <String, dynamic>{},
                (Map<String, dynamic> acc, MapEntry<String, dynamic> user) =>
                    acc..addAll({user.key: user.value}));
      } else {
        return {};
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
