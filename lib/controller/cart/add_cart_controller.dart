// ignore_for_file: use_rethrow_when_possible, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/cart_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:penstore/widgets/alerts.dart';

class AddCartController extends GetxController {
  static AddCartController get instance => Get.find();

  final isLoading = false.obs;

  // create cart
  void createCart(UserModel user, ProductModel product, int quantity,
      BuildContext context) async {
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

      if (quantity <= 0) {
        // show error snackbar
        Alerts.errorSnackBar(
          title: 'Gagal menambah keranjang!',
          message: 'Minimal tambah 1 item ke keranjang!',
        );
        Navigator.of(context).pop();
        return;

        // throw 'Quantity must be greater than 0';
      }

      final cartRepository = Get.put(CartRepository());
      await cartRepository.createCart(user, product, quantity);
      isLoading(false);

      Navigator.of(context).pop();

      // show success snackbar
      Alerts.successSnackBar(
        title: 'Berhasil menambah keranjang!',
        message: 'Lanjutkan pemesanan Anda!',
      );

      Get.toNamed('/cart');

      return;
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal menambah keranjang!',
        message: e.toString(),
      );
      // throw e;
      return;
    }
  }
}
