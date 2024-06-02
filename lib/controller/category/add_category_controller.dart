import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/category/get_categories_controller.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/repository/category_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class AddCategoryController extends GetxController {
  static AddCategoryController get to => Get.find();

  final categoryName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addCategory(BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

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

      // wait 5 seconds
      // await Future.delayed(const Duration(seconds: 5));

      final CategoryModel category =
          CategoryModel(category_name: categoryName.text.trim());

      final CategoryRepository categoryRepository =
          Get.put(CategoryRepository());
      await categoryRepository.createCategory(category);

      Navigator.pop(context);
      Get.back();

      Alerts.successSnackBar(
          title: "Berhasil!", message: "Kategori berhasil ditambahkan");

      GetCategoriesController.instance.getAllCategories();
    } catch (e) {
      Navigator.pop(context);
      Get.back();

      Alerts.errorSnackBar(
          title: "Gagal menambah kategori!", message: e.toString());
    }
  }
}
