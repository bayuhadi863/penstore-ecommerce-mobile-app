import 'package:get/get.dart';
import 'package:penstore/models/order_model.dart';
import 'package:penstore/repository/order_repository.dart';

class GetSingleOrderController extends GetxController {
  static GetSingleOrderController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final Rx<OrderModel> order = OrderModel.empty().obs;

  final String orderId;
  GetSingleOrderController(this.orderId);

  @override
  void onInit() {
    super.onInit();
    getOrderById(orderId);
  }

  void getOrderById(String orderId) async {
    try {
      isLoading(true);

      final OrderRepository orderRepository = Get.put(OrderRepository());
      final order = await orderRepository.fetchOrderById(orderId);
      this.order.value = order;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
