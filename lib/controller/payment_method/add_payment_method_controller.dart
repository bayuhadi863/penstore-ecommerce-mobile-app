// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/payment_method/get_user_payment_method_controller.dart';
import 'package:penstore/models/payment_method_model.dart';
import 'package:penstore/repository/payment_method_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class AddPaymentMethodController extends GetxController {
  static AddPaymentMethodController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<String> paymentMethodTypes = <String>[
    'Bank Mandiri',
    'Bank BCA',
    'Bank BRI',
    'DANA',
    'Gopay',
    'OVO',
    'ShopeePay',
    'LinkAja',
    'COD',
  ].obs;

  final recipientName = TextEditingController();
  final number = TextEditingController();
  // variable to store dropdown to select payment name
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addPaymentMethod(
      PaymentMethodModel paymentMethod, BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
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

        // Add payment method logic here
        final PaymentMethodRepository paymentMethodRepository =
            Get.put(PaymentMethodRepository());

        await paymentMethodRepository.createPaymentMethod(paymentMethod);

        // clear text field
        recipientName.clear();
        number.clear();

        isLoading(false);

        Navigator.of(context).pop();
        Navigator.of(context).pop();

        // show success snackbar
        Alerts.successSnackBar(
          title: 'Berhasil menambahkan metode pembayaran!',
          message: 'Anda sudah bisa menjual produk.',
        );

        GetUserPaymentMethodController.instance
            .getPaymentMethodByUserId(FirebaseAuth.instance.currentUser!.uid);
      }
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal menambahkan metode pembayaran!',
        message: e.toString(),
      );
    }
  }
}
