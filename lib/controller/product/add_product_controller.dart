import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/widgets/alerts.dart';
import 'dart:typed_data';
import 'dart:io';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;


  // form variables
  File? selectedImage;
  Uint8List? image;
  String imgUrl = "";
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descController = TextEditingController();
  String? choosedCategory;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  // upload image to get url
  Future getImageUrl() async {
    try {
      if (selectedImage != null) {
        print("mengupload gambar...");
        // image = await selectedImage!.readAsBytes();
        final productImageRepository = Get.put(ProductRepository());
        imgUrl = await productImageRepository.uploadImage(selectedImage!);
      }

      Alerts.successSnackBar(
          title: "Success", message: "Gambar berhasil diupload");
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

        if (imgUrl == "") {
          Alerts.errorSnackBar(
              title: 'Gagal', message: "Produk harus memiliki gambar");
          Navigator.of(context).pop();
        }

        final productRepository = Get.put(ProductRepository());
        await productRepository.addProduct(
            productNameController.text.trim(),
            descController.text,
            int.parse(stockController.text),
            int.parse(priceController.text),
            imgUrl,
            choosedCategory!);

        Navigator.of(context).pop();

        // Show success snackbar
        Alerts.successSnackBar(
            title: 'Sukses', message: "Berhasil menambahkan produk");

        // Go to main route
        Get.offAllNamed('/');
      }
    } catch (e) {
      Navigator.of(context).pop();
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: ("Gagal menambah produk ${e.toString()}",),
      );
    }
  }
}
