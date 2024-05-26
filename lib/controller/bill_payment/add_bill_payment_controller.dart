import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/models/bill_payment.dart';
import 'package:penstore/repository/bill_payment_repository.dart';

class AddBillPaymentController extends GetxController{
  static AddBillPaymentController get instance => Get.find();

  final RxBool isLoading = false.obs;

  Future<void> addBillPayment(BillPaymentModel billPayment, BuildContext context) async {
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
      final BillPaymentRepository billPaymentRepository = Get.put(BillPaymentRepository());
      await billPaymentRepository.createBillPayment(billPayment);
      
      

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e;
    }
  }

  
}