import 'package:get/get.dart';
import 'package:penstore/models/admin_payment_method_model.dart';
import 'package:penstore/repository/admin_payment_method_repository.dart';

class GetSingleAdminPaymentMethodController extends GetxController {
  static GetSingleAdminPaymentMethodController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final Rx<AdminPaymentMethodModel> adminPaymentMethod =
      AdminPaymentMethodModel.empty().obs;

  final String adminPaymentMethodId;
  GetSingleAdminPaymentMethodController({required this.adminPaymentMethodId});

  @override
  void onInit() {
    super.onInit();
    getAdminPaymentMethod(adminPaymentMethodId);
  }

  void getAdminPaymentMethod(String id) async {
    try {
      isLoading.value = true;

      final AdminPaymentMethodRepository adminPaymentMethodRepository =
          Get.put(AdminPaymentMethodRepository());
      final data =
          await adminPaymentMethodRepository.fetchAdminPaymentMethodById(id);
      adminPaymentMethod.value = data;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
