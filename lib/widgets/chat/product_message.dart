import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:penstore/models/chat_model.dart';

class ProductMessage extends StatelessWidget {
  ProductMessage({
    super.key,
    required this.message,
    required this.userId,
  });
  final ChatModel message;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width *
            0.75, // Maksimal 75% lebar layar
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: message.senderId == userId
            ? const Color(0xFF91E0DD).withOpacity(0.5)
            : const Color(0xFFFFFFFF),
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
          // Gambar produk
          Row(
            children: [
              Image.network(
                message.productImg!,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    message.productName!,
                    style: const TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Harga produk
                  Text(
                    message.productPrice!,
                    style: const TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Tombol untuk melihat detail produk
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/detail-product',
                  arguments: {'productId': message.productId!});
            },
            style: ElevatedButton.styleFrom(
              visualDensity: VisualDensity.comfortable,
              // maximumSize: const Size(110, 40),
              side: const BorderSide(
                color: Color(0xFF6BCCC9),
                width: 1,
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "Lihat Detail Produk",
                    style: TextStyle(
                      color: Color(0xFF6BCCC9),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFF6BCCC9),
                ),
              ],
            ),
          ),
          // Pesan chat
          Text(
            message.message!,
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 5),
          // Tanggal dan waktu
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(message.createdAt!),
                style: const TextStyle(
                  color: Color(0xFF757B7B),
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(width: 10),
              Text(
                DateFormat('hh:mm a').format(message.createdAt!),
                style: const TextStyle(
                  color: Color(0xFF757B7B),
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
