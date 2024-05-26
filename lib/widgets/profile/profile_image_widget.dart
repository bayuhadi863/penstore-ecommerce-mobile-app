import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/user_controller.dart';

class ProfileImage extends StatefulWidget {
  final String? imageUrl;
  const ProfileImage({super.key, this.imageUrl});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final double coverHeight = 250;
  final double profileHeight = 100;

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final top = coverHeight / 2 - profileHeight / 2;
    return Obx(
      () => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          buildCoverImage(),
          Positioned(
              top: top,
              child: buildProfileImage(userController.user.value.imageUrl)),
        ],
      ),
    );
  }

  buildCoverImage() => Container(
        color: const Color(0xFF91E0DD),
        height: coverHeight / 2,
        width: double.infinity,
        // child: Image(
        //   image: const AssetImage('assets/images/cover.jpg'),
        //   width: double.infinity,
        //   height: coverHeight / 2,
        //   fit: BoxFit.cover,
        // ),
      );

  buildProfileImage(String? imageUrl) => Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: profileHeight / 2,
          backgroundImage: imageUrl == null || imageUrl == ''
              ? const AssetImage('assets/images/profile.jpeg') as ImageProvider
              : NetworkImage(imageUrl), // Pastikan imageUrl bukan null
        ),
      );
}
