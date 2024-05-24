import 'package:get/get.dart';
import 'package:penstore/models/payment_method_model.dart';
import 'package:penstore/repository/payment_method_repository.dart';

class GetSinglePaymentMethodController extends GetxController {
  static GetSinglePaymentMethodController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final Rx<PaymentMethodModel> paymentMethod = PaymentMethodModel.empty().obs;

  final String paymentMethodId;
  GetSinglePaymentMethodController(this.paymentMethodId);

  @override
  void onInit() {
    super.onInit();
    getPaymentMethodById(paymentMethodId);
  }

  void getPaymentMethodById(String paymentMethodId) async {
    try {
      isLoading(true);

      final paymentMethodRepository = Get.put(PaymentMethodRepository());
      final paymentMethod =
          await paymentMethodRepository.fetchPaymentMethodById(paymentMethodId);
      this.paymentMethod.value = paymentMethod;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
