import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/product_repository.dart';

class GetSingleProduct extends GetxController {
  static GetSingleProduct get instance => Get.find();

  final isLoading = false.obs;
  final Rx<ProductModel> product = ProductModel.empty().obs;

  final String productId;

  GetSingleProduct(this.productId);

  @override
  void onInit() {
    super.onInit();
    getProduct(productId);
  }

  void getProduct(String productId) async {
    try {
      isLoading(true);

      final productRepository = Get.put(ProductRepository());
      final product = await productRepository.getProductById(productId);
      this.product.value = product;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
