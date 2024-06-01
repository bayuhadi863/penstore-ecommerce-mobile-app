import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/auth/logout_controller.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Admin Page'),
            // logout button
            ElevatedButton(
                onPressed: () async {
                  final logoutController = Get.put(LogoutController());
                  await logoutController.logout(context);
                },
                child: Text(
                  "logout",
                ))
          ],
        ),
      ),
    );
  }
}
