import 'package:get/get.dart';

class GetAdminPaymentMethodsController extends GetxController{
  static GetAdminPaymentMethodsController get instance => Get.find();

  final RxList<String> selectedPaymentMethod = <String>[].obs;
  final RxBool isAllSelected = false.obs;
  final RxInt totalPrice = 0.obs;
  final RxString sellerId = ''.obs;

  void selectPaymentMethod(String paymentMethodId, int price, int quantity, String sellerId){
    if(selectedPaymentMethod.contains(paymentMethodId)){
      selectedPaymentMethod.remove(paymentMethodId);
      isAllSelected.value = false;

      totalPrice.value -= price * quantity;
    } else {
      if(selectedPaymentMethod.isEmpty){
        this.sellerId.value = sellerId;
        selectedPaymentMethod.add(paymentMethodId);
      } else {
        if(sellerId == this.sellerId.value){
          selectedPaymentMethod.add(paymentMethodId);
        } else {
          return;
        }
      }

      totalPrice.value += price * quantity;
    }
  }

  void selectAll(List<String> paymentMethodIds, int total, String sellerId){
    if(isAllSelected.value && sellerId == this.sellerId.value){
      selectedPaymentMethod.clear();
      totalPrice.value = 0;
      isAllSelected.value = false;
    } else {
      if(selectedPaymentMethod.isEmpty){
        this.sellerId.value = sellerId;
        selectedPaymentMethod.clear();
        totalPrice.value = total;
        selectedPaymentMethod.addAll(paymentMethodIds);
        isAllSelected.value = true;
      } else {
        if(sellerId != this.sellerId.value){
          return;
        }
      }
    }
  }
    
}