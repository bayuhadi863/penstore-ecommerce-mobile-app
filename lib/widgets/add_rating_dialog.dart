import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/order/get_single_order_controller.dart';
import 'package:penstore/controller/rating/add_rating_controller.dart';
import 'package:penstore/models/rating_model.dart';

class AddRatingDialog extends StatelessWidget {
  final String productId;
  final String orderId;
  final int cartsLength;

  const AddRatingDialog({
    super.key,
    required this.productId,
    required this.orderId,
    required this.cartsLength,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final AddRatingController addRatingController =
        Get.put(AddRatingController());

    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      titlePadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      surfaceTintColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: SizedBox(
        // color: const Color(0xFF91E0DD),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/wishlist_outline.png',
                  height: 32,
                  width: 32,
                  filterQuality: FilterQuality.high,
                  color: const Color(0xFFF4CD69),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Penilaian Produk',
                  style: TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF4CD69).withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(1, 1),
                        ),
                      ]),
                  child: Image.asset(
                    'assets/icons/close_fill.png',
                    height: 24,
                    width: 24,
                    color: const Color(
                      0xFFF4CD69,
                    ),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      content: SizedBox(
        width: mediaQueryWidth,
        height: mediaQueryHeight * 0.3,
        child: SingleChildScrollView(
          child: Form(
            key: addRatingController.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Obx(() {
                      final score = addRatingController.score.value;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              addRatingController.changeScore(1);
                            },
                            child: Icon(
                              score >= 1
                                  ? Icons.star
                                  : Icons.star_border_outlined,
                              color: const Color(0xFFFFC701),
                              size: 24,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addRatingController.changeScore(2);
                            },
                            child: Icon(
                              score >= 2
                                  ? Icons.star
                                  : Icons.star_border_outlined,
                              color: const Color(0xFFFFC701),
                              size: 24,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addRatingController.changeScore(3);
                            },
                            child: Icon(
                              score >= 3
                                  ? Icons.star
                                  : Icons.star_border_outlined,
                              color: const Color(0xFFFFC701),
                              size: 24,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addRatingController.changeScore(4);
                            },
                            child: Icon(
                              score >= 4
                                  ? Icons.star
                                  : Icons.star_border_outlined,
                              color: const Color(0xFFFFC701),
                              size: 24,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addRatingController.changeScore(5);
                            },
                            child: Icon(
                              score >= 5
                                  ? Icons.star
                                  : Icons.star_border_outlined,
                              color: const Color(0xFFFFC701),
                              size: 24,
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'Berapa kualitas produknya?',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                                color: Color(0xFF757B7B),
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(
                                text:
                                    'Berikan penilaianmu sebagai evaluasi penjual',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      final descriptionError =
                          addRatingController.descriptionError.value;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        // height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFF4CD69).withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(1, 1),
                            ),
                          ],
                          // border red if error
                          border: Border.all(
                            color: descriptionError != ''
                                ? const Color(0xFFE02020)
                                : Colors.white,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          controller: addRatingController.description,
                          decoration: InputDecoration(
                            hintText: descriptionError != ''
                                ? descriptionError
                                : "Deskripsikan secara singkat",
                            hintStyle: TextStyle(
                              color: descriptionError != ''
                                  ? const Color(0xFFE02020)
                                  : const Color(0xFF757B7B),
                              fontSize: 12,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            isDense: true,
                            constraints: const BoxConstraints(
                              minHeight: 54,
                              // maxHeight: 54,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: descriptionError != ''
                                  ? BorderSide.none
                                  : const BorderSide(
                                      color: Color(0xFFF4CD69),
                                    ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          style: const TextStyle(
                              color: Color(0xFF424242),
                              fontFamily: 'poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          cursorColor: const Color(0xFFF4CD69),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4CD69),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFF4CD69),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF4CD69).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 54,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (addRatingController.description.text == '') {
                        addRatingController.changeDescriptionError(
                            "Deskripsi tidak boleh kosong");

                        return;
                      }

                      final RatingModel rating = RatingModel(
                        productId: productId,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        orderId: orderId,
                        score: addRatingController.score.value,
                        description: addRatingController.description.text,
                      );

                      await addRatingController.addRating(
                          rating, context, orderId, cartsLength);
                    },
                    child: const Center(
                      child: Text(
                        'Kirim Penilaian',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
