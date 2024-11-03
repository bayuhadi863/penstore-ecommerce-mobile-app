// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/bill_payment/get_single_bill_payment_controller.dart';
import 'package:penstore/repository/bill_payment_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class RejectBillPaymentController extends GetxController {
  static RejectBillPaymentController get instance => Get.find();

  Future<void> rejectBillPayment(
      String billPaymentId, BuildContext context) async {
    try {
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

      final BillPaymentRepository billPaymentRepository =
          Get.put(BillPaymentRepository());
      await billPaymentRepository.updateBillPaymentStatus(
          billPaymentId, 'rejected');

      Navigator.of(context).pop();
      Get.back();

      Alerts.successSnackBar(
          title: 'Berhasil!', message: 'Pembayaran berhasil ditolak!');

      GetSingleBillPaymentController.instance.getBillPaymentById(billPaymentId);
    } catch (e) {
      Navigator.of(context).pop();
      Get.back();
      Alerts.errorSnackBar(title: 'Gagal!', message: e.toString());
    }
  }
}
