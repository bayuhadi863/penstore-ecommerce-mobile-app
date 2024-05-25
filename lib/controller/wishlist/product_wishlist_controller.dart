import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/wishlist_repository.dart';

class ProductWishlistController extends GetxController {
  static ProductWishlistController to = Get.find();

  var isLoading = false.obs;
  var products = <ProductModel>[].obs;
  final wishlistNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;

  final wishlistRepository = Get.put(WishlistRepository());

  // get product by wishlist id
  Future<void> getWishlistProducts(String wishlistId) async {
    isLoading.value = true;
    try {
      products.value = await wishlistRepository.getWishlistProduct(wishlistId);

      if (products.isEmpty) {
        products.value = <ProductModel>[];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
