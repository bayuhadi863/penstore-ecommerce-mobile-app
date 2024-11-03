// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/payment_method/get_user_payment_method_controller.dart';
import 'package:penstore/repository/payment_method_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class EditPaymentMethodController extends GetxController {
  static EditPaymentMethodController get to => Get.find();

  final recipientName = TextEditingController();
  final number = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;

  final String paymentMethodId;
  EditPaymentMethodController({required this.paymentMethodId});

  @override
  void onInit() {
    super.onInit();

    getPaymentMethodById(paymentMethodId);
  }

  void getPaymentMethodById(String id) async {
    try {
      isLoading(true);

      final PaymentMethodRepository paymentMethodRepository =
          Get.put(PaymentMethodRepository());
      final paymentMethod =
          await paymentMethodRepository.fetchPaymentMethodById(id);
      recipientName.text = paymentMethod.recipientName;
      number.text = paymentMethod.number;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Alerts.errorSnackBar(
          title: 'Fetching methode pembayaran error', message: e.toString());
    }
  }

  Future<void> updatePaymentMethod(BuildContext context) async {
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

        final PaymentMethodRepository paymentMethodRepository =
            Get.put(PaymentMethodRepository());
        await paymentMethodRepository.updatePaymentMethod(
          paymentMethodId,
          recipientName.text.trim(),
          number.text.trim(),
        );

        Navigator.of(context).pop();
        Get.back();

        Alerts.successSnackBar(
            title: 'Berhasil', message: 'Metode pembayaran berhasil diubah');

        GetUserPaymentMethodController.instance
            .getPaymentMethodByUserId(FirebaseAuth.instance.currentUser!.uid);
      }
    } catch (e) {
      Navigator.of(context).pop();
      Get.back();
      // Show error snackbar
      Alerts.errorSnackBar(
        title: 'Update metode pembayaran gagal!',
        message: e.toString(),
      );
    }
  }
}
