import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/get_selected_carts_controller.dart';
import 'package:penstore/controller/cart/get_single_cart_controller.dart';
import 'package:penstore/controller/product/get_single_product.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/add_rating_dialog.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletons/skeletons.dart';

class CheckoutScreen extends StatefulWidget {
  // array of string
  final List<String>? cartIds;
  final int? totalPrice;
  const CheckoutScreen({super.key, this.cartIds, this.totalPrice});

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
  int imageHeight = 0;
  int imageWidth = 0;
  double aspectRatio = 0;
  bool isOrdered = false;
  bool isSent = false;
  bool isWaiting = false;
  bool isCheckedAll = false;
  bool isAllList = false;
  bool isPaidOff = false;

  bool isRating = false;

  final int serviceFee = 1000;

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

  void checkMetode() {
    if (selectedPaymentMethod == null) {
      Get.snackbar('Peringatan', 'Pilih Metode Pembayaran',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      setState(() {
        isOrdered = true;
      });
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

  void sentBukti() {
    if (isSent == true) {
      Get.snackbar('Berhasil', 'Bukti Pembayaran Terkirim',
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar('Gagal', 'Bukti Pembayaran Gagal Terkirim',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;

    final decodedImage =
        await decodeImageFromList(await returnImage.readAsBytes());

    setState(() {
      selectedImage = File(returnImage.path);
      image = File(returnImage.path).readAsBytesSync();
      imageHeight = decodedImage.height;
      imageWidth = decodedImage.width;
      print('Image Height : $imageHeight');
      print('Image Width : $imageWidth');
      print('Image Path : ${selectedImage!.path}');
      aspectRatio = imageWidth / imageHeight;
      // Hitung tinggi gambar yang sesuai dengan lebar Container
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
    // image picker from gallery

    final total = widget.totalPrice! + serviceFee;
    final GetSelectedCartsController getSelectedCartsController =
        Get.put(GetSelectedCartsController(widget.cartIds!));

    return Scaffold(
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
                    child: Obx(() {
                      final carts = getSelectedCartsController.selectedCart;
                      // order by created at
                      carts
                          .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

                      final isLoading =
                          getSelectedCartsController.isLoading.value;

                      // final isLoading = true;

                      return isLoading
                          ? SkeletonItem(
                              child: Column(
                                children: List.generate(
                                  2,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        bottom: 10,
                                        top: 10),
                                    child: SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        width: double.infinity,
                                        height: 100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: List.generate(
                                isAllList == true
                                    ? carts.length
                                    : carts.length > 2
                                        ? 2
                                        : carts.length,
                                (index) {
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
                                                    clipBehavior: Clip.hardEdge,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: (carts[index]
                                                                    .product
                                                                    .imageUrl !=
                                                                null &&
                                                            carts[index]
                                                                .product
                                                                .imageUrl!
                                                                .isNotEmpty)
                                                        ? Image.network(
                                                            carts[index]
                                                                .product
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
                                                  carts[index].product.name,
                                                  style: const TextStyle(
                                                    color: Color(0xFF424242),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                Text(
                                                  'Jumlah : ${carts[index].quantity}',
                                                  style: const TextStyle(
                                                    color: Color(0xFF757B7B),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                Text(
                                                  Format.formatRupiah(
                                                      carts[index]
                                                          .product
                                                          .price),
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
                                    ),
                                  );
                                },
                              ),
                            );
                    }),
                  ),
                  widget.cartIds!.length <= 2
                      ? Container()
                      : const SizedBox(
                          height: 10,
                        ),
                  widget.cartIds!.length <= 2
                      ? Container()
                      : isAllList == false
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
                      mainAxisSize:
                          MainAxisSize.min, // Menetapkan alur utama Column
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: DropdownButton<String>(
                            value: selectedPaymentMethod,
                            hint: const Text(
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
                        if (isOrdered == true) ...[
                          if (selectedPaymentMethod != null) ...[
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
                            const SizedBox(height: 15),
                          ],
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
                                      padding: const EdgeInsets.all(8.0),
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
                                                  Color(0xFF6BCCC9)),
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
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Column(
                                            children: [
                                              Text(
                                                'Bukti Pembayaran',
                                                style: TextStyle(
                                                  color: Color(0xFF757B7B),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              Text(
                                                'Seret atau pilih gambar',
                                                style: TextStyle(
                                                  color: Color(0xFF757B7B),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
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
                            ],
                            const SizedBox(height: 20),
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
                                    borderRadius: BorderRadius.circular(12),
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
                        ],
                        if (isWaiting == true) ...[
                          // const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6BCCC9).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.6),
                                  blurRadius: 16,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Color(0xFF6BCCC9),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Menunggu',
                                            style: TextStyle(
                                              color: Color(0xFF757B7B),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' Konfirmasi Pembayaran',
                                            style: TextStyle(
                                              color: Color(0xFF6BCCC9),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
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
                                                'dari penjual, kembali lagi nanti!',
                                            style: TextStyle(
                                              color: Color(0xFF757B7B),
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
                          )
                        ],
                        if (isPaidOff == true) ...[
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
                              Text(
                                Format.formatRupiah(widget.totalPrice!),
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
                              Text(
                                Format.formatRupiah(serviceFee),
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
                              Text(
                                Format.formatRupiah(total),
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
                    height: mediaQueryHeight * 0.12,
                  ),
                ],
              ),
            ),
          ),
          !isOrdered
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: mediaQueryWidth * 0.9,
                    height: 88,
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
                        Container(
                          width: 121,
                          height: 40,
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
                            child: Text(
                              Format.formatRupiah(total),
                              style: const TextStyle(
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
                          width: 101,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6BCCC9),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed('/payment-buyer');
                              checkMetode();
                            },
                            child: const Text(
                              'Pesan',
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
              : const SizedBox(),
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
      ),
    );
  }
}
