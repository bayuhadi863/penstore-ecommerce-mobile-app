// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/user_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();

  final name = TextEditingController();
  final phone = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      getCurrentUser(FirebaseAuth.instance.currentUser!.uid);
    }
  }

  void getCurrentUser(String uid) async {
    try {
      isLoading(true);

      final UserRepository userRepository = Get.put(UserRepository());
      final UserModel userModel = await userRepository.fetchUser(uid);
      name.text = userModel.name;
      phone.text = userModel.phone == null ? '' : userModel.phone!;

      isLoading(false);
    } catch (e) {
      isLoading(false);

      print(e.toString());
    }
  }

  Future updateProfile(BuildContext context, File? image) async {
    try {
      if (formKey.currentState!.validate()) {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            );
          },
          barrierDismissible: false,
        );

        final UserRepository userRepository = Get.put(UserRepository());
        if (image != null) {
          await userRepository.updateUser(
              FirebaseAuth.instance.currentUser!.uid,
              name.text.trim(),
              phone.text.trim(),
              image);
        } else {
          await userRepository.updateUser(
              FirebaseAuth.instance.currentUser!.uid,
              name.text.trim(),
              phone.text.trim(),
              null);
        }

        Navigator.of(context).pop();
        Get.back();

        // clear
        name.clear();
        phone.clear();

        // Show success snackbar
        Alerts.successSnackBar(
            title: 'Berhasil!', message: "Profile berhasil diupdate!");

        UserController.instance
            .getCurrentUser(FirebaseAuth.instance.currentUser!.uid);
      }
    } catch (e) {
      Navigator.of(context).pop();
      Get.back();
      // Show error snackbar
      Alerts.errorSnackBar(
        title: 'Update profile gagal!',
        message: e.toString(),
      );
    }
  }
}
