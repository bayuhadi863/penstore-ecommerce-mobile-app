import 'package:get/get.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/repository/cart_repository.dart';

class GetSingleCartController extends GetxController {
  static GetSingleCartController get instance => Get.find();

  final isLoading = false.obs;
  final Rx<CartModel> cart = CartModel.empty().obs;

  final String cartId;
  GetSingleCartController(this.cartId);

  @override
  void onInit() {
    super.onInit();
    getCartById(cartId);
  }

  void getCartById(String cartId) async {
    try {
      isLoading(true);

      final cartRepository = Get.put(CartRepository());
      final cart = await cartRepository.fetchCartById(cartId);
      this.cart.value = cart;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
