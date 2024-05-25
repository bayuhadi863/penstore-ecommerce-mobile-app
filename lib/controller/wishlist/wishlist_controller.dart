import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/models/wishlist_model.dart';
import 'package:penstore/repository/wishlist_repository.dart';
import 'package:penstore/widgets/alerts.dart';

// untuk membuat wishlist saja
class WishlistController extends GetxController {
  static WishlistController to = Get.find();

  var isLoading = false.obs;
  var wishlist = <WishlistModel>[].obs;
  var wishlistImage = <String>[].obs;
  var products = <ProductModel>[].obs;
  final wishlistNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;

  final wishlistRepository = Get.put(WishlistRepository());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getAllWishlist() async {
    isLoading.value = true;
    try {
      wishlist.value = await wishlistRepository.getUserWishlist(user!.uid);

      // Kosongkan wishlistImage sebelum mengisinya kembali
      wishlistImage.clear();

      // Ambil gambar pertama dari setiap wishlist
      for (var wishlistItem in wishlist) {
        String imageUrl = await wishlistRepository
            .getWishlistFirstProductImages(wishlistItem.id);
        wishlistImage.add(imageUrl);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createWishlist(BuildContext context) async {
    try {
      await wishlistRepository.createWishlist(
        wishlistNameController.text,
        user!.uid,
      );

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

  Future<String> getWishlistImage(String wishlistId) async {
    try {
      String imageUrl =
          await wishlistRepository.getWishlistFirstProductImages(wishlistId);

      if (imageUrl.isNotEmpty) {
        return imageUrl;
      } else {
        return '';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWishlist(String wishlistId) async {
    try {
      await wishlistRepository.deleteWishlist(wishlistId);

      // Show success snackbar
      Alerts.successSnackBar(
          title: 'Sukses', message: "Berhasil menghapus wishlist");
    } catch (e) {
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: ("Gagal menghapus wishlist ${e.toString()}",),
      );
    }
  }
}
