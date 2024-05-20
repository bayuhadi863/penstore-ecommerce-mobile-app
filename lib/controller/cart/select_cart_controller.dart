import 'package:get/get.dart';

class SelectCartController extends GetxController {
  static SelectCartController get instance => Get.find();

  final RxList<String> selectedCart = <String>[].obs;
  final RxBool isAllSelected = false.obs;
  final RxInt totalPrice = 0.obs;

  void selectCart(String cartId, int price, int quantity) {
    if (selectedCart.contains(cartId)) {
      selectedCart.remove(cartId);

      totalPrice.value -= price * quantity;
    } else {
      selectedCart.add(cartId);

      totalPrice.value += price * quantity;
    }
  }

  void selectAll(List<String> cartIds, int total) {
    if (isAllSelected.value) {
      selectedCart.clear();
      totalPrice.value = 0;
      isAllSelected.value = false;
    } else {
      selectedCart.clear();
      totalPrice.value = total;
      selectedCart.addAll(cartIds);
      isAllSelected.value = true;
    }
  }

  void clearAll() {
    selectedCart.clear();
  }
}
