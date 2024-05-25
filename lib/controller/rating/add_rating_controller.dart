// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/order/get_single_order_controller.dart';
import 'package:penstore/models/rating_model.dart';
import 'package:penstore/repository/check_rated_controller.dart';
import 'package:penstore/repository/order_repository.dart';
import 'package:penstore/repository/rating_repository.dart';
import 'package:penstore/widgets/alerts.dart';

class AddRatingController extends GetxController {
  static AddRatingController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxInt score = 0.obs;
  final RxString descriptionError = ''.obs;

  final description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changeScore(int value) {
    score.value = value;
  }

  void changeDescriptionError(String value) {
    descriptionError.value = value;
  }

  Future<void> addRating(RatingModel ratingData, BuildContext context,
      String orderId, int cartsLength) async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading(true);

        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            );
          },
          barrierDismissible: false,
        );

        if (ratingData.score == 0) {
          Navigator.of(context).pop();
          isLoading(false);
          Alerts.errorSnackBar(
            title: 'Gagal menambah penilaian!',
            message: 'Rating minimal adalah satu bintang!',
          );
          return;
        }

        descriptionError.value = '';

        final ratingRepository = Get.put(RatingRepository());
        await ratingRepository.createRating(ratingData);

        final ratings = await ratingRepository.fetchRatingsByOrderId(orderId);

        if (ratings.length == cartsLength) {
          await OrderRepository.instance.updateOrderStatus(orderId, "rated");
        }

        isLoading(false);

        Navigator.of(context).pop();
        Navigator.of(context).pop();

        // show success snackbar
        Alerts.successSnackBar(
          title: 'Berhasil menambah penilaian!',
          message: 'Terima kasih dan selamat berbelanja kembali!',
        );

        GetSingleOrderController.instance.getOrderById(orderId);

        final CheckRatedController checkRatedController = Get.put(
          CheckRatedController(
              orderId: orderId, productId: ratingData.productId),
          tag: "$orderId-${ratingData.productId}",
        );
        checkRatedController.checkRated(orderId, ratingData.productId);
        // CheckRatedController.instance.checkRated(orderId, ratingData.productId);
      }
    } catch (e) {
      isLoading(false);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Get.back();
      Alerts.errorSnackBar(
        title: 'Gagal menambah penilaian!',
        message: e.toString(),
      );
    }
  }
}
