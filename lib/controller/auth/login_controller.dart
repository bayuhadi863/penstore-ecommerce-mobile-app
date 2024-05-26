// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/auth_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Form variables
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Lodading variable
  final isLoading = false.obs;

  // Login function
  Future login(BuildContext context) async {
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

        // Login from AuthRepository
        final authRepository = Get.put(AuthRepository());
        await authRepository.signInWithEmail(
          email.text.trim(),
          password.text.trim(),
        );

        Navigator.of(context).pop();

        // Show success snackbar
        Alerts.successSnackBar(
            title: 'Selamat, anda berhasil login', message: "Selamat menikmati fitur-fitur yang kami sediakan di ", messageOptional: "PENSTORE");

        // Go to main route
        Get.offAllNamed('/');
      }
    } catch (e) {
      Navigator.of(context).pop();
      // Show error snackbar
      Alerts.errorSnackBar(
        title: 'Maaf, anda gagal login',
        message: getErrorMessage(
          e.toString(),
        ),
      );
    }
  }

  getErrorMessage(String error) {
    switch (error) {
      case 'invalid-credential':
        return 'Email atau password salah!';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan login. Coba lagi nanti.';
      default:
    }
    if (error == 'invalid-credential') {
      return 'Email atau password salah!';
    } else {
      return error.toString();
    }
  }
}
