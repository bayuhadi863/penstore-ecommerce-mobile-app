import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final double coverHeight = 250;
  final double profileHeight = 100;

  @override
  Widget build(BuildContext context) {
    final top = coverHeight / 2 - profileHeight / 2;
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          buildCoverImage(),
          Positioned(top: top, child: buildProfileImage()),
        ],
      ),
    );
  }

  buildCoverImage() => Container(
        color: Colors.grey,
        child: Image(
          image: const AssetImage('assets/images/cover.jpg'),
          width: double.infinity,
          height: coverHeight / 2,
          fit: BoxFit.cover,
        ),
      );

  buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const AssetImage(
          'assets/images/profile.jpeg',
        ),
      );
}
