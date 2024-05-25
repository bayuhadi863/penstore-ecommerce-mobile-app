// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/order_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class FinishOrderController extends GetxController {
  static FinishOrderController get instance => Get.find();

  final RxBool isLoading = false.obs;

  Future<void> finishOrder(String orderId, BuildContext context) async {
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
      await orderRepository.updateOrderStatus(orderId, 'received');

      isLoading(false);

      Navigator.of(context).pop();

      // show success snackbar
      Alerts.successSnackBar(
        title: 'Berhasil menyelesaikan pesanan!',
        message: 'Beri penilaian produk pesanan Anda!',
      );
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();

      Alerts.errorSnackBar(
        title: 'Gagal menyelesaikan pesanan!',
        message: e.toString(),
      );
    }
  }
}
