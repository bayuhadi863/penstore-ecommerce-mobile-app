import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alerts {
  static successSnackBar(
      {required title, message = '', duration = 2, messageOptional = ''}) {
    Get.snackbar(
      '',
      '',
      overlayBlur: 1,
      overlayColor: Colors.black.withOpacity(0.5),
      titleText: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.list_alt_outlined,
                color: Color(0xFF6BCCC9),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Notifikasi Sukses',
                style: TextStyle(
                  color: Color(0xFF424242),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/succes.png', // Ganti dengan path gambar Anda
            width: 60,
            height: 60,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: message,
                        style: const TextStyle(
                          color: Color(0xFF757B7B),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: messageOptional,
                        style: const TextStyle(
                          color: Color(0xFF6BCCC9),
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
          )
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      borderRadius: 20,
      margin: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 1500),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static errorSnackBar(
      {required title, message = '', duration = 2, messageOptional = ''}) {
    Get.snackbar(
      "",
      "",
      overlayBlur: 1,
      overlayColor: Colors.black.withOpacity(0.5),
      titleText: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.list_alt_outlined,
                color: Color(0xFFF46B69),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Notifikasi Gagal',
                style: TextStyle(
                  color: Color(0xFF424242),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/gagal.png', // Ganti dengan path gambar Anda
            width: 60,
            height: 60,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: message,
                        style: const TextStyle(
                          color: Color(0xFF757B7B),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: messageOptional,
                        style: const TextStyle(
                          color: Color(0xFF6BCCC9),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      borderRadius: 20,
      margin: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 1500),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
