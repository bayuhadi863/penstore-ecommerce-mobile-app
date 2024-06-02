import 'package:get/get.dart';
import 'package:penstore/models/payment_method_model.dart';
import 'package:penstore/repository/payment_method_repository.dart';

class GetUserPaymentMethodController extends GetxController {
  static GetUserPaymentMethodController get instance => Get.find();

  final RxList<PaymentMethodModel> paymentMethods = <PaymentMethodModel>[].obs;
  final RxBool isLoading = false.obs;

  final String userId;
  GetUserPaymentMethodController(this.userId);

  @override
  void onInit() {
    super.onInit();
    getPaymentMethodByUserId(userId);
  }

  void getPaymentMethodByUserId(String userId) async {
    try {
      isLoading(true);

      final paymentMethodRepository = Get.put(PaymentMethodRepository());
      final paymentMethods =
          await paymentMethodRepository.fetchPaymentMethodsByUserId(userId);

      print(paymentMethods.length);
      this.paymentMethods.value = paymentMethods;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
