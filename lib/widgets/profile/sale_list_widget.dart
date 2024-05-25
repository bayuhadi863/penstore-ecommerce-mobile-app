import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/get_single_cart_controller.dart';
import 'package:penstore/controller/order/get_seller_order_controller.dart';
import 'package:penstore/controller/profile/user_products_controller.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:penstore/widgets/no_data.dart';
import 'package:skeletons/skeletons.dart';

class SaleListProfile extends StatefulWidget {
  const SaleListProfile({super.key});

  @override
  State<SaleListProfile> createState() => _SaleListProfileState();
}

class _SaleListProfileState extends State<SaleListProfile> {
  bool isWaiting = true;
  bool isPaid = false;
  bool isReceived = false;
  bool isRating = false;
  bool isDone = false;

  void changeIsWaiting() {
    if (isWaiting == false) {
      setState(() {
        isPaid = !isDone;
        isWaiting = !isWaiting;
      });
    } else {
      setState(() {
        isWaiting = !isWaiting;
      });
    }
  }

  void changeIsPaid() {
    if (isPaid == false) {
      setState(() {
        isWaiting = !isWaiting;
        isPaid = !isPaid;
      });
    } else {
      setState(() {
        isPaid = !isPaid;
      });
    }
  }

  void changeIsReceived() {
    if (isReceived == false) {
      setState(() {
        isPaid = !isPaid;
        isReceived = !isReceived;
      });
    } else {
      setState(() {
        isReceived = !isReceived;
      });
    }
  }

  void changeIsRating() {
    if (isRating == false) {
      setState(() {
        isReceived = !isReceived;
        isRating = !isRating;
      });
    } else {
      setState(() {
        isRating = !isRating;
      });
    }
  }

  void changeIsDone() {
    if (isDone == false) {
      setState(() {
        isRating = !isRating;
        isDone = !isDone;
      });
    } else {
      setState(() {
        isDone = !isDone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final GetSellerOrderController getSellerOrderController =
        Get.put(GetSellerOrderController());

    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        final orders = getSellerOrderController.orders;
        // sort order by status.
        orders.sort((a, b) => a.status.compareTo(b.status));

        final loading = getSellerOrderController.isLoading.value;
        return loading
            ? SkeletonItem(
                child: Column(
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          height: 200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : orders.isEmpty
                ? const NoData(
                    title: "Maaf, ",
                    subTitle: "Belum ada pesanan",
                    suggestion: "Silahkan jual produk anda!",
                  )
                : Column(
                    children: List.generate(
                      orders.length,
                      (index) {
                        final order = orders[index];

                        final GetSingleCartController getSingleCartController =
                            Get.put(
                          GetSingleCartController(orders[index].cartIds[0]),
                          tag: orders[index]
                              .cartIds[0], // Use unique tag for each instance
                        );

                        return InkWell(
                          onTap: () {
                            Get.toNamed('/payment-seller');
                          },
                          child: Container(
                            // height: mediaQueryHeight * 0.23,
                            width: mediaQueryWidth,
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10, top: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
                                  blurRadius: 16,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: mediaQueryHeight * 0.1,
                                  child: Obx(
                                    () {
                                      final cart = getSingleCartController.cart;
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: ClipRRect(
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: (cart.value.product
                                                                  .imageUrl !=
                                                              null &&
                                                          cart
                                                              .value
                                                              .product
                                                              .imageUrl!
                                                              .isNotEmpty)
                                                      ? Image.network(
                                                          cart.value.product
                                                              .imageUrl![0],
                                                          height: 16,
                                                          width: 16,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'assets/icons/cart_outline.png',
                                                          height: 16,
                                                          width: 16,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 5),
                                              Text(
                                                cart.value.product.name,
                                                style: const TextStyle(
                                                  color: Color(0xFF424242),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Jumlah : ${cart.value.quantity}',
                                                style: const TextStyle(
                                                  color: Color(0xFF757B7B),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                Format.formatRupiah(
                                                    cart.value.product.price),
                                                style: const TextStyle(
                                                  color: Color(0xFF91E0DD),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                '${order.cartIds.length} Produk',
                                            style: const TextStyle(
                                              color: Color(0xFF757B7B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Total Pesanan : ',
                                            style: TextStyle(
                                              color: Color(0xFF757B7B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          TextSpan(
                                            text: Format.formatRupiah(
                                                order.totalPrice),
                                            style: const TextStyle(
                                              color: Color(0xFF91E0DD),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 1,
                                  width: mediaQueryWidth * 0.9,
                                  color: const Color(0xFF757B7B),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: mediaQueryWidth * 0.3,
                                      child: RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Status pembelian',
                                              style: TextStyle(
                                                color: Color(0xFF757B7B),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // width: mediaQueryWidth * 0.5,
                                      // height: 40,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.toNamed('/payment-seller',
                                                  arguments: {
                                                'orderId': order.id!
                                              })!
                                              .then((value) =>
                                                  getSellerOrderController
                                                      .getOrdersBySellerId(
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid));
                                        },
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            side: BorderSide(
                                              color: order.status == 'received'
                                                  ? const Color(0xFFF46B69)
                                                  : order.status == 'on_process'
                                                      ? const Color(0xFF69F477)
                                                      : order.status == 'rated'
                                                          ? const Color(
                                                              0xFFF4CD69)
                                                          : order.status ==
                                                                  'waiting'
                                                              ? const Color(
                                                                  0xFF6BCCC9)
                                                              : const Color(
                                                                  0xFF69A9F4),
                                            ),
                                          ),
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: order.status == 'unpaid'
                                                    ? 'Menunggu Pembayaran'
                                                    : order.status == 'waiting'
                                                        ? 'Konfirmasi Pembayaran'
                                                        : order.status ==
                                                                'on_process'
                                                            ? 'Lunas'
                                                            : order.status ==
                                                                    'received'
                                                                ? 'Diterima'
                                                                : order.status ==
                                                                        'rated'
                                                                    ? 'Sudah Dinilai'
                                                                    : '',
                                                style: TextStyle(
                                                  color: order.status ==
                                                          'received'
                                                      ? const Color(0xFFF46B69)
                                                      : order.status ==
                                                              'on_process'
                                                          ? const Color(
                                                              0xFF69F477)
                                                          : order.status ==
                                                                  'rated'
                                                              ? const Color(
                                                                  0xFFF4CD69)
                                                              : order.status ==
                                                                      'waiting'
                                                                  ? const Color(
                                                                      0xFF6BCCC9)
                                                                  : const Color(
                                                                      0xFF69A9F4),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
      }),
    );
  }
}
