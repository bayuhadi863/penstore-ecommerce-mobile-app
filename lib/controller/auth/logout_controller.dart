import 'package:get/get.dart';
import 'package:penstore/repository/auth_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class LogoutController extends GetxController {
  static LogoutController get instance => Get.find();

  // Loading variable
  final isLoading = false.obs;

  // Logout function
  Future<void> logout() async {
    try {
      // Start loading
      isLoading(true);

      // Logout from AuthRepository
      final authRepository = Get.put(AuthRepository());
      await authRepository.signOut();

      // Stop loading
      isLoading(false);

      // Show success snackbar
      Alerts.successSnackBar(
          title: 'Logout berhasil!', message: "Sampai jumpa lagi!");

      // screen redirect
    } catch (e) {
      // Stop loading
      isLoading(false);

      // Show error snackbar
      Alerts.errorSnackBar(
        title: 'Login gagal!',
        message: e.toString(),
      );
    }
  }
}
