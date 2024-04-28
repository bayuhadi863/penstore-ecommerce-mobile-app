import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  User? user = FirebaseAuth.instance.currentUser;

  // form variables
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descController = TextEditingController();
  String? choosedCategory;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

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

        final productRepository = Get.put(ProductRepository());
        await productRepository.addProduct(
            productNameController.text.trim(),
            descController.text,
            int.parse(stockController.text),
            int.parse(priceController.text),
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
