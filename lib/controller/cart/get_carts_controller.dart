import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/repository/cart_repository.dart';
import 'package:penstore/repository/user_repository.dart';

class GetCartsController extends GetxController {
  static GetCartsController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<CartModel> carts = <CartModel>[].obs;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchCart(currentUser!.uid);
    // getUser(currentUser!.uid);
    // print(carts);
  }

  void fetchCart(String uid) async {
    try {
      isLoading(true);
      final cartRepository = Get.put(CartRepository());
      final carts = await cartRepository.fetchCart(uid);
      this.carts.value = carts;

      // format carts to array of object that grouping carts by carts.product.userId
      final groupedCarts = <String, List<CartModel>>{};
      for (final cart in carts) {
        if (!groupedCarts.containsKey(cart.product.userId)) {
          groupedCarts[cart.product.userId!] = <CartModel>[];
        }
        groupedCarts[cart.product.userId]!.add(cart);
      }

      // print('grouped list = ${groupedCarts.values.toList()[1].length}');

      isLoading(false);
      // print(carts.length);
    } catch (e) {
      isLoading(false);
      printError(info: e.toString());
      rethrow;
    }
  }

  void getUser(String uid) async {
    try {
      final userRepository = Get.put(UserRepository());
      final user = await userRepository.fetchUser(uid);
      // this.user.value = user;
    } catch (e) {
      rethrow;
    }
  }
}
