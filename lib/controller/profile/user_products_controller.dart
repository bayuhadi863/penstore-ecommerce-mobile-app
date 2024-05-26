import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class UserProductsController extends GetxController {
  static UserProductsController get instance => Get.find();

  final currentUser = FirebaseAuth.instance.currentUser;
  final isLoading = false.obs;
  final RxList<ProductModel> userProducts = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());
  @override
  void onInit() {
    super.onInit();
    getUserProducts();
  }

  void getUserProducts() async {
    try {
      isLoading(true);

      // Get user products from ProductRepository

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

  void deleteProduct(String productId) async {
    try {
      await productRepository.setStockZero(productId);

      Alerts.successSnackBar(
          title: "Berhasil mengupdate produck",
          message: "Anda telah berhasil mengubah stok produk");
      // print("berhasil mengupload gambar");
    } catch (e) {
      Alerts.errorSnackBar(title: 'Gagal', message: "Gagal mengupdate produk");
      print("error : $e");
    }
  }
}
