// ignore_for_file: use_rethrow_when_possible

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/cart_repository.dart';

class AddCartController extends GetxController {
  static AddCartController get instance => Get.find();

  final isLoading = false.obs;

  // create cart
  void createCart(UserModel user, ProductModel product, int quantity) async {
    try {
      isLoading(true);

      if (quantity <= 0) {
        // show error snackbar
        Get.snackbar(
          'Error',
          'Quantity must be greater than 0',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;

        // throw 'Quantity must be greater than 0';
      }

      final cartRepository = Get.put(CartRepository());
      await cartRepository.createCart(user, product, quantity);
      isLoading(false);

      Get.snackbar(
        'Success',
        'Product added to cart',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return;
    } catch (e) {
      isLoading(false);
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // throw e;
      return;
    }
  }
}
