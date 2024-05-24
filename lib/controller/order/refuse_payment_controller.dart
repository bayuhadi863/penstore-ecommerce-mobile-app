// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/order_payment_repository.dart';
import 'package:penstore/repository/order_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class RefusePaymentController extends GetxController {
  static RefusePaymentController get instance => Get.find();

  final RxBool isLoading = false.obs;

  Future<void> refusePayment(
      String orderId, String imageUrl, BuildContext context) async {
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
      final OrderPaymentRepository orderPaymentRepository =
          Get.put(OrderPaymentRepository());

      await orderPaymentRepository.deleteImage(imageUrl);
      await orderPaymentRepository.deleteOrderPaymentByOrderId(orderId);
      await orderRepository.updateOrderStatus(orderId, 'unpaid');

      isLoading(false);

      Navigator.of(context).pop();
      Get.back();

      // show success snackbar
      Alerts.successSnackBar(
        title: 'Berhasil menolak pembayaran!',
        message: 'Tunggu pembeli mengirim bukti pembayaran lagi!',
      );
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Get.back();
      Alerts.errorSnackBar(
        title: 'Gagal menolak pembayaran!',
        message: 'Ada masalah saat menolak pembayaran. ${e.toString()}',
      );
    }
  }
}
