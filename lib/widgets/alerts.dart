import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alerts {
  static successSnackBar({required title, message = '', duration = 2}) {
    Get.snackbar(
      '',
      '',
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
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
                    text: message,
                    style: const TextStyle(
                      color: Color(0xFF757B7B),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                    ),
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
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
    );
  }

  static errorSnackBar({required title, message = '', duration = 2}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }
}
