// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/order_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class ConfirmPaymentController extends GetxController {
  static ConfirmPaymentController get instance => Get.find();

  final RxBool isLoading = false.obs;

  Future<void> confirmPayment(String orderId, BuildContext context) async {
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

      final OrderRepository orderRepository = Get.put(OrderRepository());
      await orderRepository.updateOrderStatus(orderId, 'on_process');

      isLoading(false);

      Navigator.of(context).pop();
      Get.back();

      // show success snackbar
      Alerts.successSnackBar(
        title: 'Berhasil menambahkan keranjang!',
        message: 'Lanjutkan pemesanan Anda!',
      );
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Get.back();
      Alerts.errorSnackBar(
        title: 'Gagal menambahkan keranjang!',
        message: e.toString(),
      );
    }
  }
}
