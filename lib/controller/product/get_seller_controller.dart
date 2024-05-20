import 'package:get/get.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/user_repository.dart';

class GetSellerController extends GetxController {
  static GetSellerController get instance => Get.find();

  final isLoading = false.obs;
  // User variable
  final Rx<UserModel> seller = UserModel.empty().obs;

  final String userId;

  GetSellerController(this.userId);

  @override
  void onInit() {
    super.onInit();
    getSeller(userId);
  }

  // Get seller by id
  void getSeller(String uid) async {
    try {
      isLoading(true);

      // Get seller from UserRepository
      final userRepository = Get.put(UserRepository());
      final seller = await userRepository.fetchUser(uid);
      this.seller.value = seller;
      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
