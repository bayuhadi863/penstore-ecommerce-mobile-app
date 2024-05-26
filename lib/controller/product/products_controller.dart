import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository productRepository = ProductRepository();
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var selectedCategory = '0'.obs;
  var isSearching = false.obs;

  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    _getProducts();
    searchTextController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchTextController.removeListener(_onSearchChanged);
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

// listner / fungsi onChanged
  void _onSearchChanged() {
    final query = searchTextController.text;
    isSearching.value = query.isNotEmpty;
    if (isSearching.value) {
      searchProducts(query);
    } else {
      _getProducts();
    }
  }

  Future<void> searchProducts(String query) async {
    print('sedang mencari');
    isLoading.value = true;
    try {
      products.value = await productRepository.searchProducts(query);
    } finally {
      isLoading.value = false;
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

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    if (selectedCategory.value == '0') {
      _getProducts();
    } else {
      _getProductsByCategory(category);
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
      if (selectedCategory.value == '0') {
        await _getProducts();
      } else {
        await _getProductsByCategory(selectedCategory.value);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
