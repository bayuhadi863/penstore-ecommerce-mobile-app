import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/get_single_cart_controller.dart';
import 'package:penstore/controller/order/get_user_order_controller.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:penstore/widgets/no_data.dart';
import 'package:skeletons/skeletons.dart';

class BuyListProfile extends StatefulWidget {
  const BuyListProfile({super.key});

  @override
  State<BuyListProfile> createState() => _BuyListProfileState();
}

class _BuyListProfileState extends State<BuyListProfile> {
  bool isPaid = false;
  bool isReceived = false;
  bool isRating = false;
  bool isDone = false;

  void changeIsPaid() {
    if (isPaid == false) {
      setState(() {
        isRating = !isRating;
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

    final GetUserOrderController getUserOrderController =
        Get.put(GetUserOrderController());

    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        final orders = getUserOrderController.orders;
        final loading = getUserOrderController.isLoading.value;

        // sort order by createdAt
        orders.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

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
                    subTitle: "Belum ada produk yang kamu beli",
                    suggestion: "Silahkan beli produk terlebih dahulu!",
                  )
                : Column(
                    children: List.generate(
                      orders.length,
                      (index) {
                        final GetSingleCartController getSingleCartController =
                            Get.put(
                          GetSingleCartController(orders[index].cartIds[0]),
                          tag: orders[index]
                              .cartIds[0], // Use unique tag for each instance
                        );

                        final order = orders[index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/payment-buyer', arguments: {
                              'orderId': order.id,
                            });
                          },
                          child: Container(
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  // height: mediaQueryHeight * 0.1,
                                  child: Obx(() {
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
                                                            FilterQuality.high,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        'assets/icons/cart_outline.png',
                                                        height: 16,
                                                        width: 16,
                                                        filterQuality:
                                                            FilterQuality.high,
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
                                            SizedBox(
                                              width: mediaQueryWidth * 0.55,
                                              child: Text(
                                                cart.value.product.name,
                                                style: const TextStyle(
                                                  color: Color(0xFF424242),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
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
                                  }),
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
                                  color: const Color(0xFF000000),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: mediaQueryWidth * 0.42,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            if (order.isPaymentRejected)
                                              const TextSpan(
                                                text: 'Pembayaran ditolak!',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            TextSpan(
                                              text: order.status == 'waiting' ||
                                                      order.status ==
                                                          'waiting_cod'
                                                  ? 'Menunggu konfirmasi dari penjual'
                                                  : order.status == 'on_process'
                                                      ? 'Pesanan Anda sedang diproses'
                                                      : order.status ==
                                                              'received'
                                                          ? 'Beri Nilai untuk produk ini'
                                                          : order.status ==
                                                                  'rated'
                                                              ? 'Terima kasih atas penilaiannya'
                                                              : order.status ==
                                                                      'unpaid'
                                                                  ? 'Segera lakukan pembayaran agar pesanan diproses'
                                                                  : 'Segera lakukan pembayaran agar pesanan diproses',
                                              style: const TextStyle(
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
                                    // const SizedBox(width: 10),
                                    SizedBox(
                                      width: mediaQueryWidth * 0.38,
                                      height: 40,
                                      child: TextButton(
                                        onPressed: () {
                                          if (order.status == 'waiting' ||
                                              order.status == 'waiting_cod') {
                                            Get.toNamed('/payment-buyer',
                                                arguments: {
                                                  'orderId': order.id!
                                                });
                                          }
                                          if (order.status == 'received') {
                                            Get.toNamed('/payment-buyer',
                                                arguments: {
                                                  'orderId': order.id!
                                                });
                                            return;
                                          }
                                          if (order.status == 'on_process') {
                                            Get.toNamed('/payment-buyer',
                                                arguments: {
                                                  'orderId': order.id!
                                                });
                                            return;
                                          }
                                          if (order.status == 'rated') {
                                            changeIsRating();
                                            return;
                                          }
                                          if (order.status == 'unpaid') {
                                            Get.toNamed('/payment-buyer',
                                                arguments: {
                                                  'orderId': order.id!
                                                });
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: order.status ==
                                                  'on_process'
                                              ? const Color(0xFFF46B69)
                                              : order.status == 'waiting' ||
                                                      order.status ==
                                                          'waiting_cod'
                                                  ? const Color(0xFF69F477)
                                                  : order.status == 'received'
                                                      ? const Color(0xFFF4CD69)
                                                      : order.status == 'rated'
                                                          ? const Color(
                                                              0xFF6BCCC9)
                                                          : const Color(
                                                              0xFF69A9F4),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: order.status ==
                                                            'waiting' ||
                                                        order.status ==
                                                            'waiting_cod'
                                                    ? 'Lihat Detail'
                                                    : order.status ==
                                                            'on_process'
                                                        ? 'Diterima'
                                                        : order.status ==
                                                                'received'
                                                            ? 'Nilai'
                                                            : order.status ==
                                                                    'rated'
                                                                ? 'Beli Lagi'
                                                                : order.status ==
                                                                        'unpaid'
                                                                    ? 'Bayar Sekarang'
                                                                    : 'Bayar Sekarang',
                                                style: const TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  fontSize: 13,
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
