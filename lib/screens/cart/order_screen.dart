import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:image_picker/image_picker.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? selectedPaymentMethod;
  String? accountName;
  String? accountNumber;
  String? paymentProof;
  File? selectedImage;
  Uint8List? image;

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      image = File(returnImage.path).readAsBytesSync();
    });
  }

// List of payment methods
  List<String> paymentMethods = [
    'Pilih Metode Pembayaran',
    'Transfer Bank',
    'OVO',
    'Dana',
    'Gopay',
  ];

  bool isCheckedAll = false;
  bool isAllList = false;
  final List<bool> _isCheckedList = List.generate(10, (index) => false);

  void _onCheckedAllChanged(bool? value) {
    setState(() {
      isCheckedAll = value ?? false;
      _isCheckedList.fillRange(0, _isCheckedList.length, isCheckedAll);
    });
  }

  void _onChanged(int index, bool value) {
    setState(() {
      _isCheckedList[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                              text: 'Pesanan',
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
                  children: [
                    SizedBox(
                      width: mediaQueryWidth,
                      child: Column(
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
                                      color: const Color(0xFF91E0DD)
                                          .withOpacity(0.3),
                                      blurRadius: 16,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF91E0DD)
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Checkbox(
                                        value: _isCheckedList[index],
                                        onChanged: (value) {
                                          _onChanged(index, value!);
                                        },
                                        activeColor: Colors.transparent,
                                        checkColor: const Color(0xFF6BCCC9),
                                        side: BorderSide.none,
                                      ),
                                    ),
                                    SizedBox(width: mediaQueryWidth * 0.040),
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
                                                filterQuality:
                                                    FilterQuality.high,
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Pensil Staedler 2B',
                                          style: TextStyle(
                                            color: Color(0xFF424242),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        const Text(
                                          'Jumlah : 10',
                                          style: TextStyle(
                                            color: Color(0xFF757B7B),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        const Text(
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
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isAllList == false
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAllList = true;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Lihat Semua',
                                  style: TextStyle(
                                    color: const Color(0xFF6BCCC9),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAllList = false;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Tutup Semua',
                                  style: TextStyle(
                                    color: const Color(0xFF6BCCC9),
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
                      height: 1,
                      width: mediaQueryWidth * 0.9,
                      color: const Color(0xFF000000),
                    ),
                    SizedBox(
                      height: mediaQueryHeight * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      height: selectedPaymentMethod == null ? 100 : 352,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: Container(
                        height: selectedPaymentMethod == null ? 100 : 352,
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
                            //dropdown metode pembayaran
                            Container(
                              width: double.infinity,
                              height: 40,
                              margin: const EdgeInsets.only(top: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF757B7B),
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: selectedPaymentMethod,
                                hint: Text(
                                  'Pilih Metode Pembayaran',
                                  style: TextStyle(
                                    color: Color(0xFF757B7B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                isExpanded: true,
                                underline: Container(),
                                style: const TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedPaymentMethod = newValue!;
                                  });
                                },
                                items: paymentMethods.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    enabled: value != 'Pilih Metode Pembayaran',
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            // ignore: unnecessary_null_comparison
                            if (selectedPaymentMethod != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  SizedBox(height: 10),
                                  Container(
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
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Bukti Pembayaran',
                                                    style: TextStyle(
                                                      color: Color(0xFF757B7B),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  Text(
                                                    'Seret atau pilih gambar',
                                                    style: TextStyle(
                                                      color: Color(0xFF757B7B),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Poppins',
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6BCCC9),
                                      borderRadius: BorderRadius.circular(12),
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
                                        // Get.toNamed('/checkout');
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
                              )
                            else
                              const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQueryHeight * 0.02,
                    ),
                    Container(
                      height: 1,
                      width: mediaQueryWidth * 0.9,
                      color: const Color(0xFF000000),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                const Text(
                                  'Rp 80.000.000,-',
                                  style: TextStyle(
                                    color: Color(0xFF757B7B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                const Text(
                                  'Rp 12.000,-',
                                  style: TextStyle(
                                    color: Color(0xFF757B7B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                const Text(
                                  'Rp 80.012.000,-',
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
                      height: mediaQueryHeight * 0.15,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: mediaQueryWidth * 0.9,
                height: mediaQueryHeight * 0.088,
                margin: const EdgeInsets.only(bottom: 20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFF91E0DD).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Checkbox(
                            value: isCheckedAll,
                            onChanged: _onCheckedAllChanged,
                            activeColor: Colors.transparent,
                            checkColor: const Color(0xFF6BCCC9),
                            side: BorderSide.none,
                          ),
                        ),
                        SizedBox(width: mediaQueryWidth * 0.02),
                        Text(
                          'Semua',
                          style: const TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: mediaQueryWidth * 0.351,
                      height: mediaQueryHeight * 0.048,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: const Color(0xFF6BCCC9),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: const Text(
                          'Rp 80.000.000,-',
                          style: TextStyle(
                            color: Color(0xFF6BCCC9),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Container(
                      width: mediaQueryWidth * 0.251,
                      height: mediaQueryHeight * 0.048,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6BCCC9),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('/checkout');
                        },
                        child: const Text(
                          'Periksa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
