import 'package:get/get.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/repository/cart_repository.dart';

class GetSelectedCartsController extends GetxController {
  static GetSelectedCartsController get instance => Get.find();

  final RxList<CartModel> selectedCart = <CartModel>[].obs;
  final RxBool isLoading = false.obs;

  final List<String> cartIds;

  GetSelectedCartsController(this.cartIds);

  @override
  void onInit() {
    super.onInit();
    getSelectedCarts(cartIds);
  }

  void getSelectedCarts(List<String> cartIds) async {
    try {
      isLoading(true);

      final CartRepository cartRepository = Get.put(CartRepository());
      final carts = await cartRepository.fetchCartsByIds(cartIds);
      selectedCart.value = carts;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
