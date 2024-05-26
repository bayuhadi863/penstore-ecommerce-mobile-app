// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penstore/controller/payment_method/add_payment_method_controller.dart';
import 'package:penstore/controller/payment_method/get_user_payment_method_controller.dart';
import 'package:penstore/controller/product/add_product_controller.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/models/payment_method_model.dart';
import 'package:penstore/repository/category_repository.dart';

class AddPaymentMethodWidget extends StatefulWidget {
  const AddPaymentMethodWidget({super.key});

  @override
  State<AddPaymentMethodWidget> createState() => _AddPaymentMethodWidgetState();
}

class _AddPaymentMethodWidgetState extends State<AddPaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeigth = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final AddPaymentMethodController addPaymentMethodController =
        Get.put(AddPaymentMethodController());

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFF4CD69),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 14,
          ),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: ((context) => AlertDialog(
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
                            'Metode Pembayaran',
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
                                    color: const Color(0xFF91E0DD)
                                        .withOpacity(0.3),
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
              )),
        );
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.add,
            color: Color(0xFFFFFFFF),
          ),
          Text(
            'Tambah',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
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

  bool isLoading = false;
  String? selectedPaymentMethod;

  String? paymentMethodError;

  List<String> paymentMethods = [
    'Bank Mandiri',
    'Bank BCA',
    'Bank BRI',
    'DANA',
    'Gopay',
    'OVO',
    'ShopeePay',
    'LinkAja',
    'COD (Bayar di tempat)',
  ];

  // final addPaymentMethodController = Get.put(addPaymentMethodController());

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _stockFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

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
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeigth = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final AddPaymentMethodController addPaymentMethodController =
        Get.put(AddPaymentMethodController());

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
                key: addPaymentMethodController.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: const TextSpan(
                          text: "Tambah Metode",
                          style: TextStyle(
                            color: Color(0xFF605B57),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          )),
                    ),
                    RichText(
                      maxLines: 2,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Tambahkan metode pembayaran yang bisa",
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
                    RichText(
                      maxLines: 2,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "digunakan oleh customer",
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
                            height: 48,
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: paymentMethodError != null
                                    ? Colors.red
                                    : const Color(0xFF757B7B),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: selectedPaymentMethod,
                              hint: Text(
                                'Pilih Metode Pembayaran',
                                style: TextStyle(
                                  color: paymentMethodError != null
                                      ? Colors.red
                                      : const Color(0xFF757B7B),
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

                                setState(() {
                                  paymentMethodError = null;
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
                          const SizedBox(height: 10),
                          if (selectedPaymentMethod !=
                                  'COD (Bayar di tempat)' &&
                              selectedPaymentMethod != null) ...[
                            SizedBox(
                              width: mediaQueryWidth * 0.8,
                              child: TextFormField(
                                controller:
                                    addPaymentMethodController.recipientName,
                                validator: (value) {
                                  if (value!.isEmpty || value.trim().isEmpty ) {
                                    return 'Nama Pemilik wajib diisi';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF757B7B),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF757B7B),
                                      ),
                                    ),
                                    hintText: 'Nama Pemilik Rekening',
                                    constraints: const BoxConstraints(
                                      minHeight: 40,
                                    )),
                                style: const TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: mediaQueryWidth * 0.8,
                              // height: 70,
                              child: TextFormField(
                                controller: addPaymentMethodController.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Nomor Rekening wajib diisi';
                                  } else if (double.tryParse(value) == null) {
                                    // Cek apakah value dapat di-parse menjadi angka
                                    return 'Nomor Rekening harus angka';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF757B7B),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF757B7B),
                                      ),
                                    ),
                                    hintText: 'Nomor Rekening',
                                    constraints: const BoxConstraints(
                                      // maxHeight: 40,
                                      minHeight: 30,
                                    )),
                                style: const TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
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
                            color: const Color(0xFF6BCCC9).withOpacity(0.6),
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
                        onPressed: () async {
                          if (selectedPaymentMethod == null) {
                            setState(() {
                              paymentMethodError =
                                  'Pilih metode pembayaran terlebih dahulu';
                            });
                            return;
                          }
                          final PaymentMethodModel paymentMethod =
                              PaymentMethodModel(
                            recipientName:
                                addPaymentMethodController.recipientName.text,
                            number: addPaymentMethodController.number.text,
                            name: selectedPaymentMethod!,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          );

                          await addPaymentMethodController.addPaymentMethod(
                              paymentMethod, context);

                          // Navigator.of(context).pop();
                        },
                        child: const Center(
                          child: Text(
                            'Tambah',
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
