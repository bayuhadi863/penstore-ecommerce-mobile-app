import 'package:get/get.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/category_repository.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/repository/user_repository.dart';
import 'package:penstore/repository/wishlist_repository.dart';

class OneProductController extends GetxController {
  static OneProductController get to => Get.put(OneProductController());

  final ProductRepository productRepository = Get.put(ProductRepository());
  final CategoryRepository categoryRepository = Get.put(CategoryRepository());
  final UserRepository userRepository = Get.put(UserRepository());
  final WishlistRepository wishlistRepository = Get.put(WishlistRepository());

  var isLoading = false.obs;
  var product = ProductModel.empty().obs;
  var productCategory = CategoryModel.empty().obs;
  var seller = UserModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getDetailProduct(String productId) async {
    try {
      isLoading(true);

      final Varproduct = await productRepository.getProductById(productId);
      final category =
          await categoryRepository.getCategoryById(Varproduct.categoryId);
      final sellerData = await userRepository.fetchUser(Varproduct.userId!);

      product.value = Varproduct;
      productCategory.value = category;
      seller.value = sellerData;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
