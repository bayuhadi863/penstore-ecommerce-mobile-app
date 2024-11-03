import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/order_payment/get_order_id_payment_controller.dart';

class DeleteOrderPaymentController extends GetxController {
  static DeleteOrderPaymentController get instance => Get.find();

  Future<void> deleteOrderPayment(String orderId, BuildContext context) async {
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

      final GetOrderIdPaymentController getOrderIdPaymentController =
          Get.put(GetOrderIdPaymentController(orderId));
      final orderPaymentData = getOrderIdPaymentController.orderPayment;

      if (orderPaymentData.value.id == null) {
        Navigator.of(context).pop();
        return;
      }

      

      Navigator.of(context).pop();
    } catch (e) {
      // show error snackbar
    }
  }
}
