import 'package:get/get.dart';
import 'package:penstore/models/admin_payment_method_model.dart';
import 'package:penstore/repository/admin_payment_method_repository.dart';

class GetAdminPaymentMethodsController extends GetxController {
  static GetAdminPaymentMethodsController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<AdminPaymentMethodModel> adminPaymentMethods =
      <AdminPaymentMethodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdminPaymentMethods();
  }

  void fetchAdminPaymentMethods() async {
    try {
      isLoading(true);

      final adminPaymentMethodRepository =
          Get.put(AdminPaymentMethodRepository());
      final adminPaymentMethods =
          await adminPaymentMethodRepository.fetchAdminPaymentMethods();
      this.adminPaymentMethods.value = adminPaymentMethods;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
