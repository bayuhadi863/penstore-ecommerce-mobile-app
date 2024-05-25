// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penstore/controller/cart/get_selected_carts_controller.dart';
import 'package:penstore/controller/order/finish_order_controller.dart';
import 'package:penstore/controller/order/get_single_order_controller.dart';
import 'package:penstore/controller/order_payment/add_order_payment_controller.dart';
import 'package:penstore/controller/payment_method/get_single_payment_method_controller.dart';
import 'package:penstore/controller/product/get_seller_controller.dart';
import 'package:penstore/controller/product/get_single_product.dart';
import 'package:penstore/controller/rating/get_order_rating_controller.dart';
import 'package:penstore/repository/check_rated_controller.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/add_rating_dialog.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:skeletons/skeletons.dart';

class PaymentBuyerScreen extends StatefulWidget {
  const PaymentBuyerScreen({super.key});

  @override
  State<PaymentBuyerScreen> createState() => _PaymentBuyerScreenState();
}

class _PaymentBuyerScreenState extends State<PaymentBuyerScreen> {
  bool isAllList = false;
  File? selectedImage;
  Uint8List? image;
  bool isSent = false;
  bool isWaiting = false;
  bool isPaidOff = false;
  bool isRating = false;

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

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;

    setState(() {
      selectedImage = File(returnImage.path);
      image = File(returnImage.path).readAsBytesSync();
      print('Image Path : ${selectedImage!.path}');
    });
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

    final AddOrderPaymentController addOrderPaymentController =
        Get.put(AddOrderPaymentController());

    final FinishOrderController finishOrderController =
        Get.put(FinishOrderController());

    final GetOrderRatingController getOrderRatingController =
        Get.put(GetOrderRatingController(orderId));

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/');
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   setState(() {
        //     isPaidOff = true;
        //   });
        //   checkPaid();
        // }),
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
                        Get.offAllNamed('/');
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
          // final cartIds = ['YYLAB7tJwne0TIzIoBZs']

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

                                          final CheckRatedController
                                              checkRatedController = Get.put(
                                            CheckRatedController(
                                                orderId: orderId,
                                                productId: cart.product.id),
                                            tag: "$orderId-${cart.product.id}",
                                          );

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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF91E0DD)
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
                                                          Get.toNamed(
                                                              '/detail-product',
                                                              arguments: {
                                                                'productId':
                                                                    cart.product
                                                                        .id
                                                              });
                                                        },
                                                        child: Container(
                                                          width: 80,
                                                          height: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          child: ClipRRect(
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
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
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF424242),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                        Text(
                                                          'Jumlah : ${cart.quantity}',
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF757B7B),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              Format.formatRupiah(
                                                                  cart.product
                                                                      .price),
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF91E0DD),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                            // BUTTON NILAI
                                                            if (order.status ==
                                                                    'received' ||
                                                                order.status ==
                                                                    'rated') ...[
                                                              const SizedBox(
                                                                  width: 10),
                                                              Obx(() {
                                                                final isRated =
                                                                    checkRatedController
                                                                        .isRated
                                                                        .value;

                                                                return isRated
                                                                    ? const Text(
                                                                        'Sudah dinilai',
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xFFF4CD69),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily: 'Poppins'),
                                                                      )
                                                                    : GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Get.dialog(
                                                                            AddRatingDialog(
                                                                              productId: cart.product.id,
                                                                              orderId: orderId,
                                                                              cartsLength: carts.length,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              59,
                                                                          height:
                                                                              24,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                const Color(0xFFF4CD69),
                                                                            borderRadius:
                                                                                BorderRadius.circular(6),
                                                                          ),
                                                                          child:
                                                                              const Text(
                                                                            'Nilai',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: 'Poppins',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                              }),
                                                            ],
                                                          ],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                            Obx(
                              () {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: const Color(0xFF757B7B),
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: paymentMethodData
                                                    .value.name,
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
                                            paymentMethodData
                                                .value.recipientName
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
                                      const SizedBox(height: 15),
                                      if (order.status == 'unpaid') ...[
                                        if (selectedImage != null) ...[
                                          Stack(
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                // height:, // Sesuaikan dengan tinggi gambar
                                                child: Image.memory(
                                                  image!,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        selectedImage = null;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                    style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Color(
                                                                  0xFF6BCCC9)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ] else ...[
                                          SizedBox(
                                            height: 106.61,
                                            width: double.infinity,
                                            child: DottedBorder(
                                              color: const Color(0xFF6BCCC9),
                                              strokeWidth: 1,
                                              borderType: BorderType.RRect,
                                              dashPattern: const [7, 7],
                                              strokeCap: StrokeCap.butt,
                                              radius: const Radius.circular(12),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _pickImageFromGallery();
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 106.61,
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      const Column(
                                                        children: [
                                                          Text(
                                                            'Bukti Pembayaran',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF757B7B),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                          Text(
                                                            'Seret atau pilih gambar',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF757B7B),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Image.asset(
                                                        'assets/icons/Plus.png',
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        const SizedBox(height: 20),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6BCCC9),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          width: double.infinity,
                                          height: 54,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () async {
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

                                              if (selectedImage != null) {
                                                await addOrderPaymentController
                                                    .uploadImage(
                                                        selectedImage!);
                                              }
                                              await addOrderPaymentController
                                                  .addOrderPayment(orderId);

                                              getSingleOrderController
                                                  .getOrderById(orderId);

                                              Navigator.of(context).pop();
                                            },
                                            child: const Center(
                                              child: Text(
                                                'Kirim Bukti',
                                                style: TextStyle(
                                                  color: Color(0xFFFAFAFA),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      order.status == 'waiting'
                                          ?
                                          // const SizedBox(height: 20),
                                          Container(
                                              width: double.infinity,
                                              height: 54,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF69A9F4)
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF69A9F4)
                                                            .withOpacity(0.2),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Icon(
                                                    Icons.access_time,
                                                    color: Color(0xFF69A9F4),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' Konfirmasi Pembayaran',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF69A9F4),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                                  'dari penjual, kembali lagi nanti!',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF757B7B),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                      if (order.status == 'on_process') ...[
                                        Container(
                                          width: double.infinity,
                                          height: 54,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF69F477)
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                                    width:
                                                        mediaQueryWidth * 0.03),
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
                                                              color: Color(
                                                                  0xFF757B7B),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: ' LUNAS',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF69F477),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                                                'Pesanan Anda sedang diproses',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF757B7B),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                          ),
                                        )
                                      ],
                                      if (order.status == 'received' ||
                                          order.status == 'rated') ...[
                                        Container(
                                          width: double.infinity,
                                          // height: 54,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6BCCC9)
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF6BCCC9)
                                                    .withOpacity(0.2),
                                                blurRadius: 16,
                                                offset: const Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 7.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.access_time,
                                                  color: Color(0xFF6BCCC9),
                                                ),
                                                SizedBox(
                                                    width:
                                                        mediaQueryWidth * 0.04),
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
                                                            text:
                                                                'Pesanan telah',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF757B7B),
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: ' SELESAI!',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6BCCC9),
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // RECEIVED
                                                    if (order.status ==
                                                        'received') ...[
                                                      RichText(
                                                        text: const TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Periksa pesanan Anda dan',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF757B7B),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                                  'berikan penilaian!',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF757B7B),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    // RATED
                                                    if (order.status ==
                                                        'rated') ...[
                                                      RichText(
                                                        text: const TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Sudah memberikan penilaian.',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF757B7B),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
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
                              },
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
                              final GetSellerController getSellerController =
                                  Get.put(GetSellerController(order.sellerId));
                              final seller = getSellerController.seller.value;
                              return Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/icons/note_outline.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            'Detail Penjual',
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
                                            'Nama',
                                            style: TextStyle(
                                              color: Color(0xFF757B7B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Text(
                                            seller.name,
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
                                            'Email',
                                            style: TextStyle(
                                              color: Color(0xFF757B7B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Text(
                                            seller.email,
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
                                            'No. Handphone',
                                            style: TextStyle(
                                              color: Color(0xFF757B7B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Text(
                                            seller.phone ?? '-',
                                            style: const TextStyle(
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
                              );
                            }),
                            Obx(() {
                              final ratings = getOrderRatingController.ratings;

                              return ratings.isEmpty
                                  ? Container()
                                  : Column(
                                      children: [
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
                                        Column(
                                          children: List.generate(
                                              ratings.length, (index) {
                                            final GetSingleProduct
                                                getSingleProductController =
                                                Get.put(
                                              GetSingleProduct(
                                                  ratings[index].productId),
                                              tag: ratings[index].productId,
                                            );
                                            return Container(
                                              width: double.infinity,
                                              // height: 138,
                                              margin: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10,
                                                  top: 10),
                                              child: Container(
                                                // height: 100,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                              0xFF91E0DD)
                                                          .withOpacity(0.3),
                                                      blurRadius: 16,
                                                      offset:
                                                          const Offset(1, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/note_outline.png',
                                                          width: 24,
                                                          height: 24,
                                                          color: const Color(
                                                              0xFFF4CD69),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        const Text(
                                                          'Penilaian',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF424242),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Obx(() {
                                                      final product =
                                                          getSingleProductController
                                                              .product.value;

                                                      return Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.toNamed(
                                                                      '/detail-product',
                                                                      arguments: {
                                                                        'productId':
                                                                            product.id
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    clipBehavior:
                                                                        Clip.hardEdge,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: (product.imageUrl !=
                                                                                null &&
                                                                            product
                                                                                .imageUrl!.isNotEmpty)
                                                                        ? Image
                                                                            .network(
                                                                            product.imageUrl![0],
                                                                            height:
                                                                                16,
                                                                            width:
                                                                                16,
                                                                            filterQuality:
                                                                                FilterQuality.high,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            'assets/icons/cart_outline.png',
                                                                            height:
                                                                                16,
                                                                            width:
                                                                                16,
                                                                            filterQuality:
                                                                                FilterQuality.high,
                                                                          ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
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
                                                                  product.name,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF424242),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                  softWrap:
                                                                      true,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                ),
                                                                Text(
                                                                  'Harga : ${product.price}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF757B7B),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    Container(
                                                      height: 1,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      width: double.infinity,
                                                      color: const Color(
                                                          0xFF757B7B),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              ratings[index]
                                                                          .score >=
                                                                      1
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_border_outlined,
                                                              color: const Color(
                                                                  0xFFFFC701),
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              ratings[index]
                                                                          .score >=
                                                                      2
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_border_outlined,
                                                              color: const Color(
                                                                  0xFFFFC701),
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              ratings[index]
                                                                          .score >=
                                                                      3
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_border_outlined,
                                                              color: const Color(
                                                                  0xFFFFC701),
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              ratings[index]
                                                                          .score >=
                                                                      4
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_border_outlined,
                                                              color: const Color(
                                                                  0xFFFFC701),
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              ratings[index]
                                                                          .score >=
                                                                      5
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_border_outlined,
                                                              color: const Color(
                                                                  0xFFFFC701),
                                                              size: 20,
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        // rating desc
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                ratings[index]
                                                                    .description,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF757B7B),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    );
                            }),
                            SizedBox(
                              height: order.status == 'on_process'
                                  ? mediaQueryHeight * 0.15
                                  : mediaQueryHeight * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // BUTTON DITERIMA JIKA STATUS ON PROCESS
                    if (order.status == "on_process") ...[
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
                              color: const Color(0xFFF46B69),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await finishOrderController.finishOrder(
                                    orderId, context);

                                getSingleOrderController.getOrderById(orderId);
                              },
                              child: const Center(
                                child: Text(
                                  'Pesanan Diterima',
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
                    ],

                    // BUTTON BERIKAN PENILAIAN JIKA STATUS RECEIVED
                    if (order.status == 'wkwk') ...[
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
                              color: const Color(0xFFF4CD69),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Get.dialog(
                                //   const AddRatingDialog(),
                                // );
                                // setState(() {
                                //   isRating = true;
                                // });
                              },
                              child: const Center(
                                child: Text(
                                  'Berikan penilaian produk',
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
                );
        }),
      ),
    );
  }
}
