import 'package:get/get.dart';
import 'package:penstore/models/order_payment_model.dart';
import 'package:penstore/repository/order_payment_repository.dart';

class GetOrderIdPaymentController extends GetxController {
  static GetOrderIdPaymentController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final Rx<OrderPaymentModel> orderPayment = OrderPaymentModel.empty().obs;

  final String orderId;
  GetOrderIdPaymentController(this.orderId);

  @override
  void onInit() {
    super.onInit();
    getOrderPaymentByOrderId(orderId);
  }

  void getOrderPaymentByOrderId(String orderId) async {
    try {
      isLoading(true);

      final OrderPaymentRepository orderPaymentRepository =
          Get.put(OrderPaymentRepository());
      final orderPayment =
          await orderPaymentRepository.fetchOrderPaymentByOrderId(orderId);
      this.orderPayment.value = orderPayment;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
