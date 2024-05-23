import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/order_model.dart';
import 'package:penstore/repository/order_repository.dart';

class GetUserOrderController extends GetxController {
  static GetUserOrderController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    if (currentUser != null) {
      getOrdersByUserId(currentUser!.uid);
    }
  }

  void getOrdersByUserId(String userId) async {
    try {
      isLoading(true);

      final orderRepository = Get.put(OrderRepository());
      final orders = await orderRepository.fetchOrdersByUserId(userId);
      this.orders.value = orders;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
