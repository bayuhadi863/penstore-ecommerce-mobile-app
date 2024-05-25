import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penstore/controller/cart/get_selected_carts_controller.dart';
import 'package:penstore/controller/order/confirm_payment_controller.dart';
import 'package:penstore/controller/order/get_single_order_controller.dart';
import 'package:penstore/controller/order/refuse_payment_controller.dart';
import 'package:penstore/controller/order_payment/get_order_id_payment_controller.dart';
import 'package:penstore/controller/payment_method/get_single_payment_method_controller.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/add_rating_dialog.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:skeletons/skeletons.dart';

class PaymentSellerScreen extends StatefulWidget {
  const PaymentSellerScreen({super.key});

  @override
  State<PaymentSellerScreen> createState() => _PaymentSellerScreenState();
}

class _PaymentSellerScreenState extends State<PaymentSellerScreen> {
  bool isAllList = false;
  File? selectedImage;
  bool isSent = false;
  bool isWaiting = false;
  bool isPaidOff = false;
  bool isRating = false;

  bool isLunas = false;

  bool isExpired = false;

  void checkPaid() {
    if (isPaidOff == true) {
      isWaiting = false;
      Get.snackbar('Berhasil', 'Pembayaran Berhasil',
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Gagal', 'Pembayaran Gagal',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void sentBukti() {
    if (isSent == true) {
      Get.snackbar('Berhasil', 'Bukti Pembayaran Terkirim',
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Gagal', 'Bukti Pembayaran Gagal Terkirim',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void checkBukti() {
    if (selectedImage == null) {
      Get.snackbar('Peringatan', 'Upload Bukti Pembayaran',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      setState(() {
        isSent = true;
        isWaiting = true;
        sentBukti();
      });
    }
  }

  String orderId = '';

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments = Get.arguments;
    final orderId = arguments['orderId'];

    setState(() {
      this.orderId = orderId;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> arguments = Get.arguments;
    // final orderId = arguments['orderId'];

    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final GetSingleOrderController getSingleOrderController =
        Get.put(GetSingleOrderController(orderId));

    final GetOrderIdPaymentController orderIdPaymentController =
        Get.put(GetOrderIdPaymentController(orderId));

    final ConfirmPaymentController confirmPaymentController =
        Get.put(ConfirmPaymentController());

    final RefusePaymentController refusePaymentController =
        Get.put(RefusePaymentController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 74,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // Membuat AppBar transparan
        elevation: 0,
        scrolledUnderElevation: 0, // Menghilangkan shadow pada AppBar
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //icon menu
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF91E0DD).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Color(0xFF6BCCC9),
                    ),
                  ),
                ),
                Container(
                  width: mediaQueryWidth * 0.60,
                  height: mediaQueryHeight * 0.055,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Pembayaran',
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        final order = getSingleOrderController.order.value;
        final cartIds = order.cartIds;
        final loading = getSingleOrderController.isLoading.value;

        return loading
            // 1 == 1
            ? SkeletonItem(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          height: 100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          height: 5,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          height: 150,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          height: 5,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          height: 250,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  SizedBox(
                    height: mediaQueryHeight,
                    width: mediaQueryWidth,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            final GetSelectedCartsController
                                getSelectedCartsController =
                                Get.put(GetSelectedCartsController(cartIds));
                            final carts =
                                getSelectedCartsController.selectedCart;

                            final cartLoading =
                                getSelectedCartsController.isLoading.value;
                            return cartLoading
                                ? SkeletonItem(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 10),
                                          child: SkeletonAvatar(
                                            style: SkeletonAvatarStyle(
                                              width: double.infinity,
                                              height: 100,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: List.generate(
                                      isAllList == true
                                          ? carts.length
                                          : carts.length > 1
                                              ? 1
                                              : carts.length,
                                      (index) {
                                        final cart = carts[index];

                                        return Container(
                                          width: double.infinity,
                                          height: 100,
                                          margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 10),
                                          child: Container(
                                            height: 100,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF91E0DD)
                                                      .withOpacity(0.3),
                                                  blurRadius: 16,
                                                  offset: const Offset(1, 1),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        // Get.toNamed(
                                                        //     '/detail-product');
                                                      },
                                                      child: Container(
                                                        width: 80,
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        child: ClipRRect(
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: (cart.product
                                                                          .imageUrl !=
                                                                      null &&
                                                                  cart
                                                                      .product
                                                                      .imageUrl!
                                                                      .isNotEmpty)
                                                              ? Image.network(
                                                                  cart.product
                                                                      .imageUrl![0],
                                                                  height: 16,
                                                                  width: 16,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        cart.product.name,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF424242),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                      Text(
                                                        'Jumlah : ${cart.quantity}',
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF757B7B),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                      Text(
                                                        Format.formatRupiah(
                                                            cart.product.price),
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF91E0DD),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                          }),
                          cartIds.length <= 1
                              ? Container()
                              : const SizedBox(
                                  height: 10,
                                ),
                          cartIds.length <= 1
                              ? Container()
                              : isAllList == false
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isAllList = true;
                                          });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerRight,
                                          child: const Text(
                                            'Lebih Banyak',
                                            style: TextStyle(
                                              color: Color(0xFF6BCCC9),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isAllList = false;
                                          });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerRight,
                                          child: const Text(
                                            'Lebih Sedikit',
                                            style: TextStyle(
                                              color: Color(0xFF6BCCC9),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                          SizedBox(
                            height: mediaQueryHeight * 0.02,
                          ),
                          Container(
                            height: 2,
                            width: mediaQueryWidth * 0.9,
                            color: const Color(0xFF757B7B),
                          ),
                          SizedBox(
                            height: mediaQueryHeight * 0.02,
                          ),
                          Container(
                            width: double.infinity,
                            height: 138,
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10, top: 10),
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF91E0DD)
                                        .withOpacity(0.3),
                                    blurRadius: 16,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/icons/note_outline.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Rincian Pembayaran',
                                        style: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Subtotal Produk',
                                        style: TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        Format.formatRupiah(
                                            order.totalProductPrice),
                                        style: const TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Biaya Layanan',
                                        style: TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        Format.formatRupiah(order.serviceFee),
                                        style: const TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Pembayaran',
                                        style: TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        Format.formatRupiah(order.totalPrice),
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
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediaQueryHeight * 0.02,
                          ),
                          Container(
                            height: 2,
                            width: mediaQueryWidth * 0.9,
                            color: const Color(0xFF757B7B),
                          ),
                          SizedBox(
                            height: mediaQueryHeight * 0.02,
                          ),
                          Obx(() {
                            final GetSinglePaymentMethodController
                                paymentMethod = Get.put(
                                    GetSinglePaymentMethodController(
                                        order.paymentMethodId));
                            final paymentMethodData =
                                paymentMethod.paymentMethod;
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF91E0DD)
                                        .withOpacity(0.3),
                                    blurRadius: 16,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/icons/money_outline.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Metode Pembayaran',
                                        style: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 40,
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFF757B7B),
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: paymentMethodData.value.name,
                                            style: const TextStyle(
                                              color: Color(0xFF757B7B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Nama Rekening',
                                        style: TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        paymentMethodData.value.recipientName
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'No Rek',
                                        style: TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        paymentMethodData.value.number,
                                        style: const TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  order.status == 'unpaid'
                                      ?
                                      // const SizedBox(height: 20),
                                      Container(
                                          width: double.infinity,
                                          height: 54,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6BCCC9)
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF91E0DD)
                                                    .withOpacity(0.4),
                                                blurRadius: 16,
                                                offset: const Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Icons.access_time,
                                                color: Color(0xFF6BCCC9),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                    text: const TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Menunggu',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF757B7B),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' Pembayaran',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF6BCCC9),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: const TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'dari pembeli, kembali lagi nanti!',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF757B7B),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  if (order.status == 'waiting') ...[
                                    Obx(() {
                                      final orderPayment =
                                          orderIdPaymentController
                                              .orderPayment.value;
                                      final paymentLoading =
                                          orderIdPaymentController
                                              .isLoading.value;

                                      return paymentLoading
                                          ? SkeletonItem(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 10,
                                                            top: 10),
                                                    child: SkeletonAvatar(
                                                      style:
                                                          SkeletonAvatarStyle(
                                                        width: double.infinity,
                                                        height: 50,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF6BCCC9),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                              0xFF91E0DD)
                                                          .withOpacity(0.6),
                                                      blurRadius: 16,
                                                      offset:
                                                          const Offset(1, 1),
                                                    )
                                                  ]),
                                              width: double.infinity,
                                              height: 54,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Get.dialog(
                                                    AlertDialog(
                                                      insetPadding: EdgeInsets.only(
                                                          top:
                                                              mediaQueryHeight *
                                                                  0.09,
                                                          right: 20,
                                                          left: 20),
                                                      alignment:
                                                          Alignment.topCenter,
                                                      titlePadding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              right: 20,
                                                              left: 20),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 20),
                                                      surfaceTintColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          const Color(
                                                              0xFFFFFFFF),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      title: SizedBox(
                                                        // color: const Color(0xFF91E0DD),
                                                        width: double.infinity,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  'assets/icons/wishlist_outline.png',
                                                                  height: 32,
                                                                  width: 32,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                  color: const Color(
                                                                      0xFF6BCCC9),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'Bukti Pembayaran',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF424242),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 32,
                                                                  width: 32,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              const Color(0xFF6BCCC9).withOpacity(0.3),
                                                                          blurRadius:
                                                                              16,
                                                                          offset: const Offset(
                                                                              1,
                                                                              1),
                                                                        ),
                                                                      ]),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/icons/close_fill.png',
                                                                    height: 24,
                                                                    width: 24,
                                                                    color: const Color(
                                                                        0xFF6BCCC9),
                                                                    filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      content: SizedBox(
                                                        width: mediaQueryWidth,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 300,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: const Color(
                                                                              0xFF6BCCC9)
                                                                          .withOpacity(
                                                                              0.3),
                                                                      blurRadius:
                                                                          16,
                                                                      offset:
                                                                          const Offset(
                                                                              1,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    physics:
                                                                        const BouncingScrollPhysics(
                                                                      decelerationRate:
                                                                          ScrollDecelerationRate
                                                                              .fast,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      orderPayment
                                                                          .imageUrl,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(
                                                                            0xFFF46B69),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                const Color(0xFFF46B69).withOpacity(0.6),
                                                                            blurRadius:
                                                                                16,
                                                                            offset:
                                                                                const Offset(1, 1),
                                                                          )
                                                                        ]),
                                                                    width:
                                                                        mediaQueryWidth *
                                                                            0.38,
                                                                    height: 54,
                                                                    child:
                                                                        TextButton(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        await refusePaymentController.refusePayment(
                                                                            orderId,
                                                                            orderPayment.imageUrl,
                                                                            context);

                                                                        getSingleOrderController
                                                                            .getOrderById(orderId);

                                                                        // Get.back();
                                                                      },
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            RichText(
                                                                          text: const TextSpan(
                                                                              text: 'Gagal',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Poppins',
                                                                                color: Colors.white,
                                                                                fontSize: 14,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(
                                                                            0xFF6BCCC9),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                const Color(0xFF91E0DD).withOpacity(0.6),
                                                                            blurRadius:
                                                                                16,
                                                                            offset:
                                                                                const Offset(1, 1),
                                                                          )
                                                                        ]),
                                                                    width:
                                                                        mediaQueryWidth *
                                                                            0.38,
                                                                    height: 54,
                                                                    child:
                                                                        TextButton(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        await confirmPaymentController.confirmPayment(
                                                                            orderId,
                                                                            context);

                                                                        getSingleOrderController
                                                                            .getOrderById(orderId);

                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            RichText(
                                                                          text: const TextSpan(
                                                                              text: 'Lunas',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Poppins',
                                                                                color: Colors.white,
                                                                                fontSize: 14,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Center(
                                                  child: RichText(
                                                    text: const TextSpan(
                                                        text: 'Lihat Bukti',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            );
                                    }),
                                  ],
                                  if (order.status == 'on_process') ...[
                                    Container(
                                      width: double.infinity,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF69F477)
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF69F477)
                                                .withOpacity(0.2),
                                            blurRadius: 16,
                                            offset: const Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              color: Color(0xFF69F477),
                                            ),
                                            SizedBox(
                                                width: mediaQueryWidth * 0.04),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RichText(
                                                  text: const TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Pembayaran',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF757B7B),
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' LUNAS',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF69F477),
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                RichText(
                                                  text: const TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'Segera kirim pesanan!',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF757B7B),
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            );
                          }),
                          if (isRating) ...[
                            SizedBox(
                              height: mediaQueryHeight * 0.02,
                            ),
                            Container(
                              height: 2,
                              width: mediaQueryWidth * 0.9,
                              color: const Color(0xFF757B7B),
                            ),
                            SizedBox(
                              height: mediaQueryHeight * 0.02,
                            ),
                            Container(
                              width: double.infinity,
                              height: 138,
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF91E0DD)
                                          .withOpacity(0.3),
                                      blurRadius: 16,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/icons/note_outline.png',
                                          width: 24,
                                          height: 24,
                                          color: const Color(0xFFF4CD69),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Penilaian',
                                          style: TextStyle(
                                            color: Color(0xFF424242),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Nilai Produk',
                                          style: TextStyle(
                                            color: Color(0xFF757B7B),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Color(0xFFFFC701),
                                              size: 24,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color(0xFFFFC701),
                                              size: 24,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color(0xFFFFC701),
                                              size: 24,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color(0xFFFFC701),
                                              size: 24,
                                            ),
                                            Icon(
                                              Icons.star_border_outlined,
                                              color: Color(0xFFFFC701),
                                              size: 24,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Deskripsi',
                                          style: TextStyle(
                                            color: Color(0xFF757B7B),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                          'Barang bagus asli',
                                          style: TextStyle(
                                            color: Color(0xFF757B7B),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isLunas == true) ...[
                    if (isRating == false) ...[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: mediaQueryWidth * 0.9,
                          height: 88,
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF91E0DD).withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(1, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6BCCC9),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isRating = true;
                                });
                              },
                              child: const Center(
                                child: Text(
                                  'Barang diterima pembeli',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                ],
              );
      }),
    );
  }
}
