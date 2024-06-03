import 'package:get/get.dart';
import 'package:penstore/models/rating_model.dart';
import 'package:penstore/repository/rating_repository.dart';

class GetProductRatingController extends GetxController {
  static GetProductRatingController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<RatingModel> ratings = <RatingModel>[].obs;
  final RxInt averageRating = 0.obs;

  final String productId;
  GetProductRatingController(this.productId);

  @override
  void onInit() {
    super.onInit();
    fetchRatingsByProductId(productId);
  }

  void fetchRatingsByProductId(String productId) async {
    try {
      isLoading(true);

      final ratingRepository = Get.put(RatingRepository());
      final ratings = await ratingRepository.fetchRatingsByProductId(productId);
      this.ratings.value = ratings;

      if (ratings.isNotEmpty) {
        final totalRating = ratings.map((e) => e.score).reduce((a, b) => a + b);
        averageRating((totalRating / ratings.length).round());
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }
}
