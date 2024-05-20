import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30.0), // Jarak antara bagian atas layar dan teks "Wishlist"
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Pusatkan secara horizontal
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center, // Pusatkan teks ke tengah
                    child: Text(
                      '                       Wishlist', // Teks "Wishlist"
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 100.0), // Jarak antara teks "Wishlist" dan ikon keranjang dengan tepi kanan layar
                // Container di bawah ini menambahkan bingkai di luar ikon keranjang
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), // Warna bayangan sedikit lebih gelap
                        spreadRadius: 4,
                        blurRadius: 3,
                        offset: Offset(0, 4), // Sesuaikan posisi bayangan
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(9.0), // Margin untuk bingkai luar
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1.0), // Warna dan ketebalan garis bingkai
                    ),
                    child: Image.asset(
                      'assets/icons/cart_outline.png', // Lokasi gambar
                      color: Color(0xFF6BCCC9), // Warna ikon keranjang
                      width: 24.0, // Ukuran ikon keranjang
                      height: 24.0, // Ukuran ikon keranjang
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 36.0), // Jarak antara judul dan kotak koleksi baru
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // Pusatkan ke kiri
              children: [
                DottedBorder(
                  color: Color(0xFF91E0DD),
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12.0), // Lebarkan bingkai
                  dashPattern: [6, 3],
                  child: Container(
                    width: 170, // Lebar kotak koleksi baru diperbesar
                    height: 170, // Tinggi kotak koleksi baru diperbesar
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Koleksi Baru', // Teks "Koleksi Baru"
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Color(0xFF91E0DD)),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Icon(Icons.add, color: Color(0xFF91E0DD), size: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Tambahkan widget lain di sini jika diperlukan
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: WishlistScreen()));
}
