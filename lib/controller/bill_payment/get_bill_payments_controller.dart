import 'package:get/get.dart';
import 'package:penstore/models/bill_payment.dart';
import 'package:penstore/repository/bill_payment_repository.dart';

class GetBillPaymentsController extends GetxController {
  static GetBillPaymentsController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<BillPaymentModel> billPayments = <BillPaymentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllBillPayments();
  }

  void getAllBillPayments() async {
    try {
      isLoading.value = true;

      final BillPaymentRepository billPaymentRepository =
          Get.put(BillPaymentRepository());
      final data = await billPaymentRepository.fetchAllBillPayments();
      billPayments.value = data;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
