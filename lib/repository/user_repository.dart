import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // get random name for image
  String getRandomImageName() {
    int milliseconds = DateTime.now().millisecondsSinceEpoch;
    Random random = Random(milliseconds);
    String randomString = '';
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    for (int i = 0; i < 10; i++) {
      randomString += chars[random.nextInt(chars.length)];
    }
    return randomString;
  }

  // upload image to firebase storage with parameter only File
  Future<String> uploadImage(
    File image,
  ) async {
    try {
      TaskSnapshot storageTaskSnapshot = await storage
          .ref()
          .child('users/${getRandomImageName()}.jpg')
          .putFile(image);
      String url = await storageTaskSnapshot.ref.getDownloadURL();
      return url;
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

  // delete image by url
  Future<void> deleteImage(String url) async {
    try {
      await storage.refFromURL(url).delete();
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

  // Firestore update user by user id
  Future<void> updateUser(
      String uid, String name, String phone, File? image) async {
    try {
      // get firestore user by uid
      final DocumentSnapshot documentSnapshot =
          await db.collection('users').doc(uid).get();

      // check if user exists
      if (!documentSnapshot.exists) {
        throw 'User not found';
      }

      final user = UserModel.fromSnapshot(documentSnapshot);

      if (image == null) {
        await db.collection('users').doc(uid).update({
          'name': name,
          'phone': phone,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        return;
      }

      // check if current user image url is null or is '' then add imageUrl to user
      if (user.imageUrl == null || user.imageUrl == '') {
        String imageUrl = await uploadImage(image);

        await db.collection('users').doc(uid).update({
          'name': name,
          'phone': phone,
          'imageUrl': imageUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // delete current user image
        await deleteImage(user.imageUrl!);

        // upload new image
        String imageUrl = await uploadImage(image);

        // update user with new image
        await db.collection('users').doc(uid).update({
          'name': name,
          'phone': phone,
          'imageUrl': imageUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        });
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
