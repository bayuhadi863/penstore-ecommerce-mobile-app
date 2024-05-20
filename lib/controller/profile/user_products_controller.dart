import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/product_repository.dart';

class UserProductsController extends GetxController {
  static UserProductsController get instance => Get.find();

  final currentUser = FirebaseAuth.instance.currentUser;
  final isLoading = false.obs;
  final RxList<ProductModel> userProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserProducts();
  }

  void getUserProducts() async {
    try {
      isLoading(true);

      // Get user products from ProductRepository
      final productRepository = Get.put(ProductRepository());
      // wait 3 second
      // await Future.delayed(const Duration(seconds: 3));
      final products =
          await productRepository.getProductsByUserId(currentUser!.uid);
      userProducts.value = products;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
