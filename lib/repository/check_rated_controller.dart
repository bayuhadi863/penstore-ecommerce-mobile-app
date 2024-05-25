import 'package:get/get.dart';
import 'package:penstore/repository/rating_repository.dart';

class CheckRatedController extends GetxController {
  static CheckRatedController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxBool isRated = false.obs;

  final String orderId;
  final String productId;

  CheckRatedController({required this.orderId, required this.productId});

  @override
  void onInit() {
    super.onInit();
    checkRated(orderId, productId);
  }

  void checkRated(String orderId, String productId) async {
    try {
      isLoading(true);

      final RatingRepository ratingRepository = Get.put(RatingRepository());
      final isRated = await ratingRepository.isRatingExist(orderId, productId);
      this.isRated.value = isRated;

      isLoading(false);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
