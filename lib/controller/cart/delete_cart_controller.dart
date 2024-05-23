// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/cart_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class DeleteCartController extends GetxController {
  static DeleteCartController get instance => Get.find();

  final RxBool isLoading = false.obs;

  void deleteCart(List<String> cartIds, BuildContext context) {
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
      // delete cart from CartRepository
      final CartRepository cartRepository = Get.put(CartRepository());
      // delete cart for each cartId

      cartIds.forEach((cartId) async {
        await cartRepository.deleteCart(cartId);
      });

      isLoading(false);

      Navigator.of(context).pop();

      // show success snackbar
      Alerts.successSnackBar(
        title: 'Berhasil!',
        message: 'Berhasil menghapus barang dari keranjang!',
      );
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal menghapus keranjang!',
        message: e.toString(),
      );
      // throw e;
      return;
    }
  }
}
