// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/payment_method/get_single_payment_method_controller.dart';
import 'package:penstore/models/order_model.dart';
import 'package:penstore/repository/cart_repository.dart';
import 'package:penstore/repository/order_repository.dart';
import 'package:penstore/repository/payment_method_repository.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class AddOrderController extends GetxController {
  static AddOrderController get instance => Get.find();

  final isLoading = false.obs;
  final Rx<OrderModel> orderData = OrderModel.empty().obs;

  final note = TextEditingController();

  // create order from OrderRepository
  Future<void> createOrder(OrderModel order, BuildContext context) async {
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

      final CartRepository cartRepository = Get.put(CartRepository());
      final carts = await cartRepository.fetchCartsByIds(order.cartIds);

      // for each carts check is cart.quantity > cart.product.stock
      for (var cart in carts) {
        final productRepository =
            Get.put(ProductRepository(), tag: cart.product.id);
        final product = await productRepository.getProductById(cart.product.id);
        if (cart.quantity > product.stock) {
          isLoading(false);
          Navigator.of(context).pop();
          Alerts.errorSnackBar(
            title: 'Gagal menambahkan pesanan!',
            message: 'Stok produk ${cart.product.name} tidak mencukupi!',
          );
          return;
        }
      }

      // create order from OrderRepository
      final OrderRepository orderRepository = Get.put(OrderRepository());
      final OrderModel orderData = await orderRepository.createOrder(order);
      this.orderData.value = orderData;

      final PaymentMethodRepository paymentMethodRepository =
          Get.put(PaymentMethodRepository());
      final paymentMethod = await paymentMethodRepository
          .fetchPaymentMethodById(orderData.paymentMethodId);

      // check if payment method is COD
      if (paymentMethod.name == 'COD (Bayar di tempat)') {
        await orderRepository.updateOrderStatus(orderData.id!, 'on_process');
      }

      isLoading(false);

      Navigator.of(context).pop();

      // show success snackbar
      Alerts.successSnackBar(
        title: 'Berhasil menambahkan pesanan!',
        message: 'Segera lakukan pembayaran!',
      );

      // Get.toNamed('/payment-buyer', arguments: {'orderId': orderData.id!});
      Get.offNamedUntil(
          '/payment-buyer',
          arguments: {'orderId': orderData.id!},
          (route) => route.isFirst);
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal menambahkan pesanan!',
        message: e.toString(),
      );
      // throw e;
      return;
    }
  }
}
