import 'package:get/get.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/repository/category_repository.dart';

class GetCategoriesController extends GetxController {
  static GetCategoriesController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  void getAllCategories() async {
    try {
      isLoading(true);

      final CategoryRepository categoryRepository =
          Get.put(CategoryRepository());
      final data = await categoryRepository.getCategories();
      // print('data ${data.length}');
      categories.value = data;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
