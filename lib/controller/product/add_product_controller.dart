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

      Alerts.successSnackBar(
          title: "Success", message: "Gambar berhasil diupload");
      print("berhasil mengupload gambar");
    } catch (e) {
      Alerts.errorSnackBar(title: 'Gagal', message: "Gagal mengupload gambar");
      print("error : $e");
    }
  }

  Future addProduct(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
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

        if (imgUrls.isEmpty) {
          Alerts.errorSnackBar(
              title: 'Gagal', message: "Produk harus memiliki gambar");
          Navigator.of(context).pop();
        }

        await productRepository.addProduct(
            productNameController.text.trim(),
            descController.text,
            int.parse(stockController.text),
            int.parse(priceController.text),
            imgUrls,
            choosedCategory!,
            user!.uid);

        // Show success snackbar
        Alerts.successSnackBar(
            title: 'Sukses', message: "Berhasil menambahkan produk");

        // Navigator.of(context).pop();
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
