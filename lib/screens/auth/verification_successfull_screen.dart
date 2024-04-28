import 'package:flutter/material.dart';
import 'package:penstore/screens/bottom_navigation.dart'; // Import bottom_navigation.dart

class VerificationSuccessfullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20), // Penurunan jarak antara bagian atas dan gambar
                Image.asset(
                  'assets/icons/verification_successful.png',
                  width: 250,
                  height: 250,
                ),
                SizedBox(height: 50), // Penambahan jarak antara gambar dan teks "Verifikasi Berhasil"
                Text(
                  'Verifikasi Berhasil',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: const Color(0xFF6BCCC9),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Email kamu sudah berhasil terverifikasi sekarang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF757B7B),
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    backgroundColor: const Color(0xFF6BCCC9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                    minimumSize: Size(350, 50),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyBottomNavBar()), // Ganti dengan MyBottomNavBar()
                      (route) => false,
                    );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
