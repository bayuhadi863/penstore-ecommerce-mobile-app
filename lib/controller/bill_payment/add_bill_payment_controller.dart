// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/models/bill_payment.dart';
import 'package:penstore/repository/bill_payment_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class AddBillPaymentController extends GetxController {
  static AddBillPaymentController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> addBillPayment(int total, String billId,
      String adminPaymentMethodId, BuildContext context, File image) async {
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

      // call repository to create bill
      final BillPaymentRepository billPaymentRepository =
          Get.put(BillPaymentRepository());

      final imageUrl = await billPaymentRepository.uploadImage(image);

      final BillPaymentModel billPayment = BillPaymentModel(
        total: total,
        billId: billId,
        userId: currentUser.uid,
        imageUrl: imageUrl,
        status: 'waiting',
        adminPaymentMethodId: adminPaymentMethodId,
        createdAt: DateTime.now(),
      );

      await billPaymentRepository.createBillPayment(billPayment);

      Navigator.of(context).pop();
      Get.back();

      isLoading(false);

      Alerts.successSnackBar(
          title: 'Bukti Pembayaran Terkirim!',
          message: 'Tunggu Admin memverifikasi pembayaran.');
    } catch (e) {
      isLoading(false);

      Navigator.of(context).pop();
      Get.back();

      Alerts.errorSnackBar(
          title: 'Gagal Mengirim Bukti Pembayaran', message: e.toString());
    }
  }
}
