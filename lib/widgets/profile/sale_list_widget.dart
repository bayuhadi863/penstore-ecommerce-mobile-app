import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/user_products_controller.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';

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

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: List.generate(
          10,
          (index) {
            return Container(
              // height: mediaQueryHeight * 0.23,
              width: mediaQueryWidth,
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mediaQueryHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed('/detail-product');
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(12),
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
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              'Pensil Staedler 2B',
                              style: TextStyle(
                                color: Color(0xFF424242),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Jumlah : 10',
                              style: TextStyle(
                                color: Color(0xFF757B7B),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Rp 40.000 -',
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '2 Produk',
                              style: TextStyle(
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
                            TextSpan(
                              text: 'Total Pesanan : ',
                              style: TextStyle(
                                color: Color(0xFF757B7B),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextSpan(
                              text: 'Rp 80.000, -',
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
                  const SizedBox(height: 5),
                  Container(
                    height: 1,
                    width: mediaQueryWidth * 0.9,
                    color: const Color(0xFF757B7B),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: mediaQueryWidth * 0.3,
                        child: RichText(
                          text: TextSpan(
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
                            isWaiting
                                ? changeIsPaid()
                                : isPaid
                                    ? changeIsReceived()
                                    : isReceived
                                        ? changeIsRating()
                                        : isRating
                                            ? changeIsDone()
                                            : changeIsWaiting();
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: isWaiting
                                      ? 'Menunggu Pembayaran'
                                      : isPaid
                                          ? 'Konfirmasi Pembayaran'
                                          : isReceived
                                              ? 'Lunas'
                                              : isRating
                                                  ? 'Sudah Dinilai'
                                                  : isDone
                                                      ? 'Selesai'
                                                      : 'Menunggu Pembayaran',
                                  style: TextStyle(
                                    color: isWaiting
                                        ? Color(0xFF69A9F4)
                                        : isPaid
                                            ? Color(0xFF6BCCC9)
                                            : isReceived
                                                ? Color(0xFF69F477)
                                                : isRating
                                                    ? Color(0xFFF4CD69)
                                                    : isDone
                                                        ? Color(0xFFF46B69)
                                                        : Color(0xFF69A9F4),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: isWaiting
                                    ? Color(0xFF69A9F4)
                                    : isPaid
                                        ? Color(0xFF6BCCC9)
                                        : isReceived
                                            ? Color(0xFF69F477)
                                            : isRating
                                                ? Color(0xFFF4CD69)
                                                : isDone
                                                    ? Color(0xFFF46B69)
                                                    : Color(0xFF69A9F4),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
