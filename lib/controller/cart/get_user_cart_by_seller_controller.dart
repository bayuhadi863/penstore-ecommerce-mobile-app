import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/repository/cart_repository.dart';

class GetUserCartBySellerController extends GetxController {
  static GetUserCartBySellerController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<CartModel> carts = <CartModel>[].obs;

  final String sellerId;
  GetUserCartBySellerController(this.sellerId);

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    getUserCartsBySellerId(sellerId);
  }

  void getUserCartsBySellerId(String sellerId) async {
    try {
      isLoading(true);
      final cartRepository = Get.put(CartRepository());
      final carts =
          await cartRepository.fetchCartBySellerId(currentUser!.uid, sellerId);
      this.carts.value = carts;
      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
