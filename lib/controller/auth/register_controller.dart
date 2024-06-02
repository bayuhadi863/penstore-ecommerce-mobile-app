import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/auth/middleware_controller.dart';
import 'package:penstore/repository/auth_repository.dart';
import 'package:penstore/repository/user_repository.dart';
import 'package:penstore/screens/bottom_navigation.dart';
import 'package:penstore/widgets/alerts.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  // Form variables
  final name = TextEditingController();
  final email = TextEditingController();
  // final phone = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();

  // Loading variable
  final isLoading = false.obs;

  // Register function
  void register(BuildContext context) async {
    try {
      if (formKeyRegister.currentState!.validate()) {
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

        // Register from AuthRepository
        final authRepository = Get.put(AuthRepository());
        final user = await authRepository.signUpWithEmail(
          email.text.trim(),
          password.text.trim(),
        );

        // Create user to users collection from UserRepository
        final userRepository = Get.put(UserRepository());
        await userRepository.createUser(
          user!.uid,
          name.text.trim(),
          email.text.trim(),
          // phone.text.trim(),
        );

        // clear form
        name.clear();
        email.clear();
        // phone.clear();
        password.clear();

        Navigator.of(context).pop();

        // Show success snackbar
        Alerts.successSnackBar(
            title: 'Registrasi berhasil!',
            message: "Selamat datang di PENSTORE!");

        // Go to main route
        Get.offAllNamed('/');
      }
    } catch (e) {
      Navigator.of(context).pop();
      // Show error snackbar
      Alerts.errorSnackBar(
        title: 'Registrasi gagal!',
        message: getErrorMessage(
          e.toString(),
        ),
      );
    }
  }

  getErrorMessage(String error) {
    switch (error) {
      case 'email-already-in-use':
        return 'Email sudah terdaftar. Silahkan login.';
      case 'weak-password':
        return 'Password terlalu lemah.';
      case 'invalid-email':
        return 'Email tidak valid.';
      default:
        return error.toString();
    }
  }
}
