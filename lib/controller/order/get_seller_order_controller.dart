import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/order_model.dart';
import 'package:penstore/repository/order_repository.dart';

class GetSellerOrderController extends GetxController {
  static GetSellerOrderController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    if (currentUser != null) {
      getOrdersBySellerId(currentUser!.uid);
    }
  }

  void getOrdersBySellerId(String sellerId) async {
    try {
      isLoading(true);

      final orderRepository = Get.put(OrderRepository());
      final orders = await orderRepository.fetchOrdersBySellerId(sellerId);
      this.orders.value = orders;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
