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
      await orderRepository.updateOrderPaymentRejected(orderId, false);

      isLoading(false);

      Navigator.of(context).pop();
      Get.back();

      // show success snackbar
      Alerts.successSnackBar(
        title: 'Berhasil mengonfirmasi pembayaran!',
        message: 'Segera kirim pesanan ke pembeli!',
      );
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Get.back();
      Alerts.errorSnackBar(
        title: 'Gagal mengonfirmasi pembayaran!',
        message: e.toString(),
      );
    }
  }
}
