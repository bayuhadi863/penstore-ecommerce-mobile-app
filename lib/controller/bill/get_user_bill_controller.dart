import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/bill_model.dart';
import 'package:penstore/repository/bill_repository.dart';

class GetUserBillController extends GetxController {
  static GetUserBillController get instance => Get.find();

  final isLoading = false.obs;
  final Rx<BillModel> bill = BillModel.empty().obs;

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void onInit() {
    super.onInit();
    getBillByUserId(currentUser.uid);
  }

  void getBillByUserId(String userId) async {
    try {
      isLoading(true);

      final billRepository = Get.put(BillRepository());
      final bill = await billRepository.fetchBill(userId);
      this.bill.value = bill;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
