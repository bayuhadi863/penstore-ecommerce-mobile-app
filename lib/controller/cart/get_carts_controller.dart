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
      isLoading(false);
      print(carts.length);
    } catch (e) {
      isLoading(false);
      printError(info: e.toString());
      throw e;
    }
  }

  void getUser(String uid) async {
    try {
      final userRepository = Get.put(UserRepository());
      final user = await userRepository.fetchUser(uid);
      // this.user.value = user;
    } catch (e) {
      throw e;
    }
  }
}
