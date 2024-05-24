import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penstore/controller/product/add_product_controller.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/repository/category_repository.dart';

class FormTagihanWidget extends StatefulWidget {
  const FormTagihanWidget({super.key});

  @override
  State<FormTagihanWidget> createState() => _FormTagihanWidgetState();
}

class _FormTagihanWidgetState extends State<FormTagihanWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeigth = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.all(20),
      contentPadding: EdgeInsets.zero,
      surfaceTintColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: SizedBox(
        width: mediaQueryWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.list_alt_outlined,
                  color: Color(0xFF91E0DD),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Tagihan Anda',
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
                          color: const Color(0xFF91E0DD).withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(1, 1),
                        ),
                      ]),
                  child: Image.asset(
                    'assets/icons/close_fill.png',
                    height: 24,
                    width: 24,
                    color: const Color(
                      0xFF91E0DD,
                    ),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      content: const ProductForm(),
    );
  }
}

// DIDELE KENE BEN CONTEXT STATE E FUNGSI NAK ALERT DIALOG E
class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  List<CategoryModel> categories = [];
  String? choosedCategory;
  bool isLoading = false;
  String? selectedPaymentMethod;
  File? selectedImage;
  Uint8List? image;

  List<String> paymentMethods = [
    'Bank BRI',
    'OVO',
    'Dana',
    'Gopay',
  ];

  final addProductController = Get.put(AddProductController());

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _stockFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  // variabel list gambar
  final List<File> selectedImages = [];
  final List<Uint8List> images = [];

  bool isWaiting = false;

  bool isPaidOff = false;

  bool isSent = false;

  void checkBukti() {
    if (selectedImage == null) {
      Get.snackbar('Peringatan', 'Upload Bukti Pembayaran',
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      setState(() {
        isSent = true;
        isWaiting = true;
      });
    }
  }

  Future<void> _getCategories() async {
    setState(() {
      isLoading = true;
    });

    final CategoryRepository categoryRepository = CategoryRepository();
    final List<CategoryModel> data_categories =
        await categoryRepository.getCategories();
    setState(() {
      categories = data_categories;
      isLoading = false;
    });
  }

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _stockFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // jika belum login
    if (user == null) {
      Get.offAllNamed("/login");
    }
    print("user sekarang : $user");
    _getCategories();
  }

  // UPLOAD GAMBAR  ==============================
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;

    final decodedImage =
        await decodeImageFromList(await returnImage.readAsBytes());

    setState(() {
      selectedImage = File(returnImage.path);
      image = File(returnImage.path).readAsBytesSync();
      print('Image Path : ${selectedImage!.path}');
      // Hitung tinggi gambar yang sesuai dengan lebar Container
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeigth = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return isLoading
        ? const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ),
          )
        : SizedBox(
            width: mediaQueryWidth,
            child: SingleChildScrollView(
              child: Form(
                key: addProductController.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Rp. 10.0000.000,-",
                      style: TextStyle(
                          color: Color(0xFF91E0DD),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Bayar sesuai nominal",
                          style: TextStyle(
                            color: Color(0xFF605B57),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          )),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Pembayaran digunakan sebagai biaya admin aplikasi",
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      padding: const EdgeInsets.all(10),
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
                                fontWeight: FontWeight.w500,
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
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          if (selectedPaymentMethod != null) ...[
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
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF91E0DD)
                                        .withOpacity(0.3),
                                    blurRadius: 16,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
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
                                    color: const Color(0xFF91E0DD)
                                        .withOpacity(0.6),
                                    blurRadius: 16,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6BCCC9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF6BCCC9),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6BCCC9).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: 54,
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () async {},
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
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}