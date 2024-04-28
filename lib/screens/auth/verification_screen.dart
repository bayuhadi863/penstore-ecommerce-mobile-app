import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/screens/auth/verification_successfull_screen.dart';

class VerificationScreen extends StatelessWidget {
  final String email;

  VerificationScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200), // Jarak vertikal antara bagian atas layar dan gambar
            Image.asset(
              'assets/icons/verification.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 70), // Jarak vertikal antara gambar dan teks "Verifikasi Email"
            Text(
              'Verifikasi Email',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10), // Jarak vertikal antara teks "Verifikasi Email" dan teks alamat email
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Color(0xFF757B7B),
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
                children: [
                  TextSpan(text: 'Pada email '),
                  TextSpan(
                    text: email,
                    style: TextStyle(
                      color: Color(0xFF6BCCC9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // Jarak vertikal antara teks alamat email dan tombol "Lanjut"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6BCCC9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
                minimumSize: Size(350, 50), // Ukuran minimum tombol "Lanjut"
                padding: EdgeInsets.symmetric(horizontal: 40), // Menambah ruang di sekitar teks tombol
              ),
              onPressed: () {
                Get.to(VerificationSuccessfullScreen()); // Navigasi ke layar verifikasi berhasil
              },
              child: Text(
                'Lanjut',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20), // Jarak vertikal antara tombol "Lanjut" dan teks "Belum menerima email?"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum menerima email? ',
                  style: TextStyle(
                    color: Color(0xFF757B7B),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Tambahkan kode untuk mengirim ulang email di sini
                    // Misalnya, Anda bisa menampilkan snackbar atau pesan sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Email telah berhasil dikirim ulang!'),
                      ),
                    );
                  },
                  child: Text(
                    'Resend Email !',
                    style: TextStyle(
                      color: Color(0xFF6BCCC9),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
