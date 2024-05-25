import 'package:get/get.dart';
import 'package:penstore/models/rating_model.dart';
import 'package:penstore/repository/rating_repository.dart';

class GetOrderRatingController extends GetxController {
  static GetOrderRatingController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<RatingModel> ratings = <RatingModel>[].obs;

  final String orderId;
  GetOrderRatingController(this.orderId);

  @override
  void onInit() {
    super.onInit();
    fetchRatingsByOrderId(orderId);
  }

  void fetchRatingsByOrderId(String orderId) async {
    try {
      isLoading(true);

      final ratingRepository = Get.put(RatingRepository());
      final ratings = await ratingRepository.fetchRatingsByOrderId(orderId);
      this.ratings.value = ratings;

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
