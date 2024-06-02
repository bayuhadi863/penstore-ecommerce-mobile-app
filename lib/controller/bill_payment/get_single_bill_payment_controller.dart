import 'package:get/get.dart';
import 'package:penstore/models/bill_payment.dart';
import 'package:penstore/repository/bill_payment_repository.dart';

class GetSingleBillPaymentController extends GetxController {
  static GetSingleBillPaymentController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final Rx<BillPaymentModel> billPayment = BillPaymentModel.empty().obs;

  final String billPaymentId;
  GetSingleBillPaymentController({required this.billPaymentId});

  @override
  void onInit() {
    super.onInit();
    getBillPaymentById(billPaymentId);
  }

  void getBillPaymentById(String id) async {
    try {
      isLoading.value = true;

      final BillPaymentRepository billPaymentRepository =
          Get.put(BillPaymentRepository());
      final data = await billPaymentRepository.fetchBillPaymentById(id);
      billPayment.value = data;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
