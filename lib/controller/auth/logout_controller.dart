// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/auth_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class LogoutController extends GetxController {
  static LogoutController get instance => Get.find();

  // Loading variable
  final isLoading = false.obs;

  // Logout function
  Future<void> logout(BuildContext context) async {
    try {
      // Start loading
      isLoading(true);

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

      // Logout from AuthRepository
      final authRepository = Get.put(AuthRepository());
      await authRepository.signOut();

      // Stop loading
      isLoading(false);

      // Navigator.of(context).pop();
      // Get.back();

      // Show success snackbar
      Alerts.successSnackBar(
          title: 'Logout berhasil!', message: "Sampai jumpa lagi!");

      // screen redirect
    } catch (e) {
      // Stop loading
      isLoading(false);

      // Navigator.of(context).pop();
      // Get.back();

      // Show error snackbar
      Alerts.errorSnackBar(
        title: 'Login gagal!',
        message: e.toString(),
      );
    }
  }
}
