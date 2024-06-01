import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/repository/user_repository.dart';
import 'package:penstore/screens/admin/admin_home_screen.dart';
import 'package:penstore/screens/auth/login_screen.dart';
import 'package:penstore/screens/bottom_navigation.dart';

class Middleware extends StatelessWidget {
  const Middleware({super.key});

  @override
  Widget build(BuildContext context) {


    final authUser = FirebaseAuth.instance.currentUser;

    if (authUser == null) {
      return const LoginScreen(); // Tampilkan layar login jika user belum login
    }

    return FutureBuilder(
      future: _checkAdminStatus(authUser.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
          // Tampilkan loader saat menunggu
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          ); // Tampilkan layar error jika ada masalah
        } else {
          final isAdmin = snapshot.data as bool;

          if (isAdmin) {
            return const AdminHomeScreen(); // Tampilkan layar admin jika user adalah admin
          } else {
            return const MyBottomNavBar(); // Tampilkan layar user jika user bukan admin
          }
        }
      },
    );
  }

  Future<bool> _checkAdminStatus(String uid) async {
    final UserRepository userRepository = Get.put(UserRepository());
    final user = await userRepository.fetchUser(uid);
    return user.isAdmin == true;
  }
}
