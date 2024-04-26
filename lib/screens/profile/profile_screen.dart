import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/auth/logout_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final logoutController = Get.put(LogoutController());
            logoutController.logout();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
