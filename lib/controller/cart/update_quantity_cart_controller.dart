import 'package:get/get.dart';
import 'package:penstore/repository/cart_repository.dart';

class UpdateQuantityCartController extends GetxController {
  static UpdateQuantityCartController get instance => Get.find();

  final RxInt quantity = 1.obs;

  final String cartId;
  UpdateQuantityCartController(this.cartId);

  final CartRepository cartRepository = Get.put(CartRepository());

  @override
  void onInit() {
    super.onInit();
    getCartQuantity(cartId);
  }

  void increment(String cartId) async {
    try {
      await cartRepository.addCartQuantity(cartId, 1);
      quantity.value++;
    } catch (e) {
      // throw e.toString();
      return;
    }
  }

  void decrement(String cartId) async {
    try {
      await cartRepository.subtractCartQuantity(cartId, 1);
      quantity.value--;
    } catch (e) {
      // throw e.toString();
      return;
    }
  }

  void getCartQuantity(String cartId) async {
    try {
      final cart = await cartRepository.fetchCartById(cartId);
      quantity.value = cart.quantity;
    } catch (e) {
      throw e.toString();
    }
  }
}
