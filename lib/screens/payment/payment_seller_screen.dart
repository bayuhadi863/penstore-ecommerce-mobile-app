import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penstore/widgets/add_rating_dialog.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
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
      body: Stack(
        children: [
          SizedBox(
            height: mediaQueryHeight,
            width: mediaQueryWidth,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: List.generate(
                      isAllList == true ? 10 : 2,
                      (index) {
                        return Container(
                          width: double.infinity,
                          height: 100,
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
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
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
                                        Get.toNamed('/detail-product');
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image(
                                            filterQuality: FilterQuality.high,
                                            image: AssetImage(
                                              imgList[0],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Buku Tulis",
                                        style: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        'Jumlah : 2',
                                        style: TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        'Rp. 20.000.000',
                                        style: TextStyle(
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
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isAllList == false
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                            color: const Color(0xFF91E0DD).withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal Produk',
                                style: TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                "Rp. 12.000.000,-",
                                style: TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Biaya Layanan',
                                style: TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                "Rp. 1.000,-",
                                style: TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                "Rp. 10.000.000,-",
                                style: TextStyle(
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
                  Container(
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
                          color: const Color(0xFF91E0DD).withOpacity(0.3),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                const TextSpan(
                                  text: 'Bank BRI',
                                  style: TextStyle(
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Rekening',
                              style: TextStyle(
                                color: Color(0xFF757B7B),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'SENJANI NATHANIA',
                              style: TextStyle(
                                color: Color(0xFF757B7B),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No Rek',
                              style: TextStyle(
                                color: Color(0xFF757B7B),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              '9200045678910',
                              style: TextStyle(
                                color: Color(0xFF757B7B),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (!isLunas && !isExpired) ...[
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF6BCCC9),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF91E0DD)
                                        .withOpacity(0.6),
                                    blurRadius: 16,
                                    offset: const Offset(1, 1),
                                  )
                                ]),
                            width: double.infinity,
                            height: 54,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Get.dialog(
                                  AlertDialog(
                                    insetPadding: EdgeInsets.only(
                                        top: mediaQueryHeight * 0.09,
                                        right: 20,
                                        left: 20),
                                    alignment: Alignment.topCenter,
                                    titlePadding: EdgeInsets.only(
                                        top: 20, right: 20, left: 20),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    surfaceTintColor: Colors.white,
                                    backgroundColor: const Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: SizedBox(
                                      // color: const Color(0xFF91E0DD),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/icons/wishlist_outline.png',
                                                height: 32,
                                                width: 32,
                                                filterQuality:
                                                    FilterQuality.high,
                                                color: const Color(0xFF6BCCC9),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Bukti Pembayaran',
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
                                                        color: const Color(
                                                                0xFF6BCCC9)
                                                            .withOpacity(0.3),
                                                        blurRadius: 16,
                                                        offset:
                                                            const Offset(1, 1),
                                                      ),
                                                    ]),
                                                child: Image.asset(
                                                  'assets/icons/close_fill.png',
                                                  height: 24,
                                                  width: 24,
                                                  color:
                                                      const Color(0xFF6BCCC9),
                                                  filterQuality:
                                                      FilterQuality.high,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF6BCCC9)
                                                            .withOpacity(0.3),
                                                    blurRadius: 16,
                                                    offset: const Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: SingleChildScrollView(
                                                  physics:
                                                      BouncingScrollPhysics(
                                                    decelerationRate:
                                                        ScrollDecelerationRate
                                                            .fast,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/cover.jpg',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
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
                                                            0xFF6BCCC9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                    0xFF91E0DD)
                                                                .withOpacity(
                                                                    0.6),
                                                            blurRadius: 16,
                                                            offset:
                                                                const Offset(
                                                                    1, 1),
                                                          )
                                                        ]),
                                                    width:
                                                        mediaQueryWidth * 0.38,
                                                    height: 54,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          isLunas = true;
                                                        });
                                                        Get.back();
                                                      },
                                                      child: Center(
                                                        child: RichText(
                                                          text: const TextSpan(
                                                              text: 'Lunas',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                              )),
                                                        ),
                                                      ),
                                                    )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFF46B69),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                    0xFFF46B69)
                                                                .withOpacity(
                                                                    0.6),
                                                            blurRadius: 16,
                                                            offset:
                                                                const Offset(
                                                                    1, 1),
                                                          )
                                                        ]),
                                                    width:
                                                        mediaQueryWidth * 0.38,
                                                    height: 54,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          isExpired = true;
                                                        });
                                                        Get.back();
                                                      },
                                                      child: Center(
                                                        child: RichText(
                                                          text: const TextSpan(
                                                              text: 'Gagal',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                              )),
                                                        ),
                                                      ),
                                                    ))
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
                        if (isLunas) ...[
                          Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color(0xFF69F477).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF69F477).withOpacity(0.3),
                                  blurRadius: 16,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Color(0xFF69F477),
                                  ),
                                  SizedBox(width: mediaQueryWidth * 0.04),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Pembayaran',
                                              style: TextStyle(
                                                color: Color(0xFF757B7B),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' LUNAS',
                                              style: TextStyle(
                                                color: Color(0xFF69F477),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF91E0DD).withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min, 
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
