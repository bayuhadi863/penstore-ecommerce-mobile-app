import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/order_payment_model.dart';
import 'package:penstore/repository/order_payment_repository.dart';
import 'package:penstore/repository/order_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class AddOrderPaymentController extends GetxController {
  static AddOrderPaymentController get instance => Get.find();

  final isLoading = false.obs;
  final RxString imageUrl = ''.obs;
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> uploadImage(File image) async {
    try {
      isLoading(true);
      // upload image to get url
      final OrderPaymentRepository orderPaymentRepository =
          Get.put(OrderPaymentRepository());
      final String imgUrl = await orderPaymentRepository.uploadImage(image);
      imageUrl.value = imgUrl;
      isLoading(false);
    } catch (e) {
      Alerts.errorSnackBar(
          title: 'Gagal', message: "Gagal mengupload gambar ${e.toString()}");
      // print("error : $e");
    }
  }

  Future<void> addOrderPayment(String orderId) async {
    try {
      isLoading(true);

      // check if imageUrl is empty
      if (imageUrl.value.isEmpty) {
        isLoading(false);
        Alerts.errorSnackBar(
            title: 'Gagal', message: "Bukti pembayaran tidak boleh kosong");
        return;
      }

      final OrderPaymentModel orderPayment = OrderPaymentModel(
        orderId: orderId,
        imageUrl: imageUrl.value,
      );

      final OrderPaymentRepository orderPaymentRepository =
          Get.put(OrderPaymentRepository());
      await orderPaymentRepository.addOrderPayment(orderPayment);

      final OrderRepository orderRepository = Get.put(OrderRepository());
      await orderRepository.updateOrderPaymentRejected(orderId, false);

      isLoading(false);
      Alerts.successSnackBar(
          title: "Success", message: "Berhasil mengirim bukti pembayaran");
    } catch (e) {
      isLoading(false);
      Alerts.errorSnackBar(
          title: 'Gagal',
          message: "Gagal mengirim bukti pembayaran, ${e.toString()}");
    }
  }
}
