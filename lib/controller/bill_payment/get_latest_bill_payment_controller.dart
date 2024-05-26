import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/bill_payment.dart';
import 'package:penstore/repository/bill_payment_repository.dart';

class GetLatestBillPaymentController extends GetxController {
  static GetLatestBillPaymentController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<BillPaymentModel> billPaymentData = <BillPaymentModel>[].obs;

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void onInit() {
    super.onInit();
    getLatestBillPayment(currentUser.uid);
  }

  void getLatestBillPayment(String userId) async {
    try {
      isLoading(true);

      // get latest bill payment from BillPaymentRepository
      final BillPaymentRepository billPaymentRepository =
          Get.put(BillPaymentRepository());
      final billPayments =
          await billPaymentRepository.fetchBillPaymentsByUserId(userId);
      billPaymentData.value = billPayments;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
