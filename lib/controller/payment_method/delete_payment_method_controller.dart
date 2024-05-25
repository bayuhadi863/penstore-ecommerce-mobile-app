// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/payment_method_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class DeletePaymentMethodController extends GetxController {
  static DeletePaymentMethodController get instance => Get.find();

  final RxBool isLoading = false.obs;

  Future<void> deletePaymentMethod(
      String paymentMethodId, BuildContext context) async {
    try {
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

      final PaymentMethodRepository paymentMethodRepository =
          Get.put(PaymentMethodRepository());
      await paymentMethodRepository.deletePaymentMethod(paymentMethodId);

      isLoading(false);

      Navigator.of(context).pop();

      // show success snackbar
      Alerts.successSnackBar(
        title: 'Metode pembayaran dihapus!',
        message: 'Jangan biarkan metode pembayaran kosong.',
      );
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal menghapus metode pembayaran!',
        message: e.toString(),
      );
    }
  }
}
