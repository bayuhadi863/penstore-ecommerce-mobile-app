import 'package:flutter/material.dart';

class EditPaymentMethod extends StatefulWidget {
  final String paymentMethodId;

  const EditPaymentMethod({super.key, required this.paymentMethodId});

  @override
  State<EditPaymentMethod> createState() => _EditPaymentMethodState();
}

class _EditPaymentMethodState extends State<EditPaymentMethod> {
  @override
  Widget build(BuildContext context) {
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
                  'Ubah metode pembayaran',
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
      content: EditPaymentMethodForm(),
    );
  }
}

class EditPaymentMethodForm extends StatefulWidget {
  const EditPaymentMethodForm({super.key});

  @override
  State<EditPaymentMethodForm> createState() => _EditPaymentMethodForm();
}

class _EditPaymentMethodForm extends State<EditPaymentMethodForm> {
  String? selectedPaymentMethod;
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

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: mediaQueryWidth,
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: const TextSpan(
                  text: "Ubah Metode Pembayaran",
                  style: TextStyle(
                    color: Color(0xFF605B57),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              RichText(
                maxLines: 2,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Ubah  metode pembayaran yang bisa",
                      style: TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                          color: const Color(0xFF757B7B),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedPaymentMethod,
                        hint: Text(
                          'Pilih Metode Pembayaran',
                          style: TextStyle(
                            color: const Color(0xFF757B7B),
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
                    const SizedBox(height: 10),
                    SizedBox(
                      width: mediaQueryWidth * 0.8,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.trim().isEmpty) {
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () async {},
                  child: const Center(
                    child: Text(
                      'Simpan',
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
