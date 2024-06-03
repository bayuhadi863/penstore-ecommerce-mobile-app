import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class EditProductController extends GetxController {
  static EditProductController instance = Get.put(EditProductController());

  var product = ProductModel.empty().obs;
  List<String> previousImgUrls = [];
  List<String> newImgUrls = [];
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descController = TextEditingController();
  String? choosedCategory;

  var updatedProduct = ProductModel.empty();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final ProductRepository productRepository = Get.put(ProductRepository());

  Future<void> getData(String productId) async {
    try {
      isLoading(true);

      final product = await productRepository.getProductById(productId);

      productNameController.text = product.name;
      priceController.text = product.price.toString();
      stockController.text = product.stock.toString();
      descController.text = product.desc;
      choosedCategory = product.categoryId;
      previousImgUrls = product.imageUrl!;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }

  Future<void> saveProduct(String productId, BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        isLoading.value = true;

        if (newImgUrls.isEmpty && previousImgUrls.isEmpty) {
          Alerts.errorSnackBar(
            title: 'Gagal',
            message: "Gambar produk tidak boleh kosong",
          );
          isLoading.value = false;
          return;
        }

        // update nilai
        updatedProduct = ProductModel(
          id: productId,
          name: productNameController.text,
          desc: descController.text,
          stock: int.parse(stockController.text),
          price: int.parse(priceController.text),
          categoryId: choosedCategory!,
          userId: '',
          imageUrl: previousImgUrls + newImgUrls,
        );

        await productRepository.updateProduct(updatedProduct);

        await Future.delayed(const Duration(seconds: 2));
        isLoading.value = false;

        Alerts.successSnackBar(
            title: 'Sukses', message: "Berhasil mengupdate produk");

        Navigator.of(context).pop();

        previousImgUrls.clear();
        newImgUrls.clear();

        // Go to main route
        // Get.offAllNamed('/');
      }
    } catch (e) {
      print(e);
      Alerts.errorSnackBar(
        title: 'Gagal',
        message: "Gagal mengupdate produk ${e.toString()}",
      );
    }
  }

  Future<void> getImageUrls(List<File> selectedImages) async {
    try {
      for (final File image in selectedImages) {
        print("mengupload gambar...");
        final productImageRepository = Get.put(ProductRepository());
        final String imgUrl = await productImageRepository.uploadImage(image);
        newImgUrls.add(imgUrl);
      }

      // Alerts.successSnackBar(
      //     title: "Success", message: "Gambar berhasil diupload");
      print("berhasil mengupload gambar");
    } catch (e) {
      Alerts.errorSnackBar(title: 'Gagal', message: "Gagal mengupload gambar");
      print("error : $e");
    }
  }
}
