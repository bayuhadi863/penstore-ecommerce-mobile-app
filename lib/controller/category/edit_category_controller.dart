import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/category_repository.dart';
import 'package:penstore/widgets/alerts.dart';
import 'package:penstore/controller/category/get_categories_controller.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get to => Get.find();

  final categoryName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;

  final String categoryId;
  EditCategoryController({required this.categoryId});

  @override
  void onInit() {
    super.onInit();
    getCategory(categoryId);
  }

  void getCategory(String categoryId) async {
    try {
      isLoading(true);

      final CategoryRepository categoryRepository =
          Get.put(CategoryRepository());
      final data = await categoryRepository.getCategoryById(categoryId);
      categoryName.text = data.category_name;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }

  Future<void> updateCategory(BuildContext context) async {
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

      final CategoryRepository categoryRepository =
          Get.put(CategoryRepository());
      await categoryRepository.editCategory(
          categoryId, categoryName.text.trim());

      Navigator.pop(context);
      Get.back();

      Alerts.successSnackBar(
          title: "Berhasil!", message: "Kategori berhasil diubah");

      GetCategoriesController.instance.getAllCategories();
    } catch (e) {
      Navigator.pop(context);
      Get.back();

      Alerts.errorSnackBar(
          title: "Gagal mengubah kategori!", message: e.toString());
    }
  }
}
