import 'package:get/get.dart';
import 'package:penstore/widgets/alerts.dart';

class SelectCartController extends GetxController {
  static SelectCartController get instance => Get.find();

  final RxList<String> selectedCart = <String>[].obs;
  final RxBool isAllSelected = false.obs;
  final RxInt totalPrice = 0.obs;
  final RxString sellerId = ''.obs;

  void selectCart(String cartId, int price, int quantity, String sellerId) {
    if (selectedCart.contains(cartId)) {
      selectedCart.remove(cartId);
      isAllSelected.value = false;

      totalPrice.value -= price * quantity;
    } else {
      if (selectedCart.isEmpty) {
        this.sellerId.value = sellerId;
        selectedCart.add(cartId);
      } else {
        if (sellerId == this.sellerId.value) {
          selectedCart.add(cartId);
        } else {
          Alerts.errorSnackBar(
              title: 'Error',
              message:
                  'Anda hanya bisa memilih barang dari penjual yang sama!');
          return;
        }
      }

      totalPrice.value += price * quantity;
    }
  }

  void selectAll(List<String> cartIds, int total, String sellerId) {
    print('sellerId: $sellerId');

    if (isAllSelected.value && sellerId == this.sellerId.value) {
      selectedCart.clear();
      totalPrice.value = 0;
      isAllSelected.value = false;
      print('sellerIdController: ${this.sellerId.value}');
      print('clear');
    } else {
      if (selectedCart.isEmpty) {
        this.sellerId.value = sellerId;
        selectedCart.clear();
        totalPrice.value = total;
        selectedCart.addAll(cartIds);
        isAllSelected.value = true;

        print('sellerIdController: ${this.sellerId.value}');
        print('adding empty');
      } else {
        if (sellerId != this.sellerId.value) {
          Alerts.errorSnackBar(
              title: 'Error',
              message:
                  'Anda hanya bisa memilih barang dari penjual yang sama!');
          print('error');
          return;
        } else {
          selectedCart.clear();
          totalPrice.value = total;
          selectedCart.addAll(cartIds);
          isAllSelected.value = true;
          print('sellerIdController: ${this.sellerId.value}');
          print('adding not empty');
        }
      }
    }
  }

  void clearAll() {
    selectedCart.clear();
    totalPrice.value = 0;
  }

  void addTotalPrice(int price) {
    totalPrice.value += price;
  }

  void removeTotalPrice(int price) {
    totalPrice.value -= price;
  }
}
