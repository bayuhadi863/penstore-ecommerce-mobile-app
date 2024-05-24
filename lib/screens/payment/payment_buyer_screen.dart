// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penstore/controller/cart/get_selected_carts_controller.dart';
import 'package:penstore/controller/order/get_single_order_controller.dart';
import 'package:penstore/controller/payment_method/get_single_payment_method_controller.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/add_rating_dialog.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final orderId = arguments['orderId'];

    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final GetSingleOrderController getSingleOrderController =
        Get.put(GetSingleOrderController(orderId));

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/');
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            isPaidOff = true;
          });
          checkPaid();
        }),
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
          // final cartIds = ['YYLAB7tJwne0TIzIoBZs'];

          return loading
              ? const CircularProgressIndicator()
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

                              return Column(
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
                                                    Get.toNamed(
                                                        '/detail-product');
                                                  },
                                                  child: Container(
                                                    width: 80,
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: ClipRRect(
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    cart.product.name,
                                                    style: const TextStyle(
                                                      color: Color(0xFF424242),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  Text(
                                                    'Jumlah : ${cart.quantity}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF757B7B),
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
                                                      color: Color(0xFF91E0DD),
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
                                      if (isSent == false) ...[
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
                                            onPressed: () {
                                              setState(() {
                                                checkBukti();
                                              });
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
                                      if (isWaiting == true) ...[
                                        // const SizedBox(height: 20),
                                        Container(
                                          width: double.infinity,
                                          height: 54,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6BCCC9)
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' Konfirmasi Pembayaran',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF6BCCC9),
                                                            fontSize: 14,
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
                                                              'dari penjual, kembali lagi nanti!',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF757B7B),
                                                            fontSize: 14,
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
                                      ],
                                      if (isPaidOff == true) ...[
                                        Container(
                                          width: double.infinity,
                                          height: 54,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF69F477)
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF69F477)
                                                    .withOpacity(0.3),
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
                                                            text: 'Pembayaran',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF757B7B),
                                                              fontSize: 14,
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
                                                              fontSize: 14,
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
                                      ]
                                    ],
                                  ),
                                );
                              },
                            ),
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
                            SizedBox(
                              height: mediaQueryHeight * 0.15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isPaidOff == true) ...[
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
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
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
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AddRatingDialog();
                                      });
                                  setState(() {
                                    isRating = true;
                                  });
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
                  ],
                );
        }),
      ),
    );
  }
}
