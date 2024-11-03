import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/widgets/alerts.dart';
import 'dart:io';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;

  // form variables
  List<String> imgUrls = [];

  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descController = TextEditingController();
  String? choosedCategory;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final productRepository = Get.put(ProductRepository());

  // upload image to get url
  Future<void> getImageUrls(List<File> selectedImages) async {
    try {
      for (final File image in selectedImages) {
        print("mengupload gambar...");
        final String imgUrl = await productRepository.uploadImage(image);
        imgUrls.add(imgUrl);
      }

      // Alerts.successSnackBar(
      //     title: "Berhasil mengupload gambar", message: "Anda telah berhasil menambahkan gambar");
      // print("berhasil mengupload gambar");
    } catch (e) {
      Alerts.errorSnackBar(title: 'Gagal', message: "Gagal mengupload gambar");
      print("error : $e");
    }
  }

  Future addProduct(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        if (imgUrls.isEmpty) {
          Alerts.errorSnackBar(
              title: 'Gagal', message: "Produk harus memiliki gambar");

          Navigator.of(context).pop();

          return;
        }

        await productRepository.addProduct(
            productNameController.text.trim(),
            descController.text,
            int.parse(stockController.text),
            int.parse(priceController.text),
            imgUrls,
            choosedCategory!,
            user!.uid);

        productNameController.clear();
        priceController.clear();
        stockController.clear();
        descController.clear();
        choosedCategory = null;
        imgUrls.clear();

        // Show success snackbar
        Alerts.successSnackBar(
            title: 'Berhasil menambah data',
            message: "Selamat, Anda telah Berhasil menambah data produk");

        Navigator.of(context).pop();
      }
    } catch (e) {
      Navigator.of(context).pop();
      print(e);
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: "Gagal menambah produk ${e.toString()}",
      );
    }
  }
}
