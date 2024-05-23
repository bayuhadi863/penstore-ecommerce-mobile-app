import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/wishlist_repository.dart';
import 'package:penstore/widgets/alerts.dart';

// untuk membuat wishlist saja
class AddProductWishlistController extends GetxController {
  static AddProductWishlistController to = Get.find();

  User? user = FirebaseAuth.instance.currentUser;

  final wishlistNameController = TextEditingController();
  bool isAddNewWishlist = false;
  String? choosedWishlist;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  // buat wishlist
  Future<String> createWishlist() async {
    try {
      final wishlistRepository = Get.put(WishlistRepository());
      String wishlistId = await wishlistRepository.createWishlist(
          user!.uid, wishlistNameController.text);

      // Show success snackbar
      Alerts.successSnackBar(
          title: 'Sukses', message: "Berhasil membuat wishlist");

      return wishlistId;
    } catch (e) {
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: ("Gagal menambah produk ${e.toString()}",),
      );
      return "";
    }
  }

  // check if product is already in wishlist
  Future<bool> checkWishlist(String productId) async {
    try {
      final wishlistRepository = Get.put(WishlistRepository());
      bool isExist =
          await wishlistRepository.isProductInWishlist(productId, user!.uid);

      return isExist;
    } catch (e) {
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: ("Gagal mengecek produk ${e.toString()}",),
      );
      return false;
    }
  }

  // insert product in wishlist
  Future<void> addToWishlist(
      String productId, String wishlistId, BuildContext context) async {
    try {
      final wishlistRepository = Get.put(WishlistRepository());
      await wishlistRepository.addToWishlist(wishlistId, productId);

      if (await checkWishlist(productId)) {
        Alerts.errorSnackBar(
          title: 'Gagal',
          message: ("Produk sudah ada pada wishlist ",),
        );
      } else {
        Navigator.of(context).pop();

        // Show success snackbar
        Alerts.successSnackBar(
            title: 'Sukses',
            message: "Berhasil menambahkan produk ke wishlist");
      }
    } catch (e) {
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: "Gagal menambah produk ke wishlist ${e.toString()}",
      );
    }
  }
}
