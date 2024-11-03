import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/category/get_categories_controller.dart';
import 'package:penstore/repository/category_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class DeleteCategoryController extends GetxController {
  static DeleteCategoryController get to => Get.find();

  Future<void> deleteCategory(String categoryId, BuildContext context) async {
    try {
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

      final CategoryRepository categoryRepository =
          Get.put(CategoryRepository());
      await categoryRepository.deleteCategory(categoryId);

      Navigator.of(context).pop();
      Get.back();

      Alerts.successSnackBar(
          title: "Berhasil!", message: "Kategori berhasil dihapus");

      GetCategoriesController.instance.getAllCategories();
    } catch (e) {
      Navigator.of(context).pop();
      Get.back();

      Alerts.errorSnackBar(
          title: "Gagal menghapus kategori!", message: e.toString());
    }
  }
}
