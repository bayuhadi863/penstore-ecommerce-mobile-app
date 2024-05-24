import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/product_repository.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var selectedCategory = ''.obs;

  final ProductRepository productRepository = ProductRepository();

  @override
  void onInit() {
    super.onInit();
    _getProducts();
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    if (selectedCategory.value == 'semua') {
      _getProducts();
    } else {
      _getProductsByCategory(category);
    }
  }

  Future<void> _getProducts() async {
    isLoading.value = true;
    try {
      products.value = await productRepository.getAllProducts();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getProductsByCategory(String category) async {
    isLoading.value = true;
    try {
      products.value =
          await productRepository.getProductsByCategoryId(category);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reloadGetData() async {
    try {
      isLoading.value = true;
      if (selectedCategory.value == 'semua') {
        await _getProducts();
      } else {
        await _getProductsByCategory(selectedCategory.value);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
