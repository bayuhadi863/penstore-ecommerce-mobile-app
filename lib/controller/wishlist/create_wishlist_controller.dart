import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/wishlist_repository.dart';
import 'package:penstore/widgets/alerts.dart';

// untuk membuat wishlist saja
class CreateWishlistController extends GetxController {
  static CreateWishlistController to = Get.find();

  User? user = FirebaseAuth.instance.currentUser;

  final wishlistNameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  Future<void> createWishlist(BuildContext context) async {
    try {
      final wishlistRepository = Get.put(WishlistRepository());
      await wishlistRepository.createWishlist(
          user!.uid, wishlistNameController.text);

      Navigator.of(context).pop();

      // Show success snackbar
      Alerts.successSnackBar(
          title: 'Sukses', message: "Berhasil membuat wishlist");
    } catch (e) {
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: ("Gagal menambah produk ${e.toString()}",),
      );
    }
  }
}
