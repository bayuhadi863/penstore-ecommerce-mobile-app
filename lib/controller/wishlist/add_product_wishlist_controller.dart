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

  final wishlistRepository = Get.put(WishlistRepository());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  // buat wishlist
  Future<String> createWishlist() async {
    print(wishlistNameController);
    try {
      print("membuat wishlist");
      String wishlistId = await wishlistRepository.createWishlist(
        wishlistNameController.text,
        user!.uid,
      );

      // Show success snackbar
      Alerts.successSnackBar(
          title: 'Sukses', message: "Berhasil membuat wishlist");

      print("new wishlist $wishlistId");
      print('ini tipe ${wishlistId.runtimeType}');

      wishlistNameController.text = "";
      return wishlistId;
    } catch (e) {
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: "Gagal membuat wishlist produk ${e.toString()}",
      );
      return "";
    }
  }

  // check if product is already in wishlist
  Future<bool> checkWishlist(String productId) async {
    try {
      bool isExist =
          await wishlistRepository.isProductInWishlist(productId, user!.uid);

      return isExist;
    } catch (e) {
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: "Gagal mengecek produk ${e.toString()}",
      );
      return false;
    }
  }

  // insert product in wishlist
  Future<void> addToWishlist(
      String productId, String wishlistId, BuildContext context) async {
    try {
      if (await checkWishlist(productId)) {
        Alerts.errorSnackBar(
          title: 'Gagal',
          message: "Produk sudah ada pada wishlist ",
        );
        return;
      }

      await wishlistRepository.addToWishlist(wishlistId, productId);

      Navigator.of(context).pop();

      // Show success snackbar
      Alerts.successSnackBar(
          title: 'Sukses', message: "Berhasil menambahkan produk ke wishlist");

      // await reloadVariable();
    } catch (e) {
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: "Gagal menambah produk ke wishlist ${e.toString()}",
      );
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    try {
      await wishlistRepository.removeFromWishlist(productId, user!.uid);

      Alerts.successSnackBar(
          title: 'Sukses', message: "Berhasil menghapus produk dari wishlist");
      // await reloadVariable();
    } catch (e) {
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: "Gagal menghapus produk dari wishlist ${e.toString()}",
      );
    }
  }
}
