import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:penstore/screens/auth/login_screen.dart';
import 'package:penstore/screens/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedIndex = 0;
  late PageController controller;

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  @override
  void initState() {
    controller =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.45,
              width: size.width,
              color: const Color(0xFF6BCCC9),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: const Color(0xFF6BCCC9), width: 1),
                            color: const Color(0xFF6BCCC9),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF91E0DD).withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(
                            'assets/images/logo_pens.png',
                            color: Colors.white,
                            height: 23,
                            width: 32,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await completeOnboarding();
                            Get.offAll(() =>
                                FirebaseAuth.instance.currentUser != null
                                    ? const MyBottomNavBar()
                                    : const LoginScreen());
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Skip",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF757B7B),
                                fontFamily: 'Poppins',
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView.builder(
                          itemCount: KDummyData.onBoardItemList.length,
                          controller: controller,
                          onPageChanged: (v) {
                            setState(() {
                              selectedIndex = v;
                            });
                          },
                          itemBuilder: (context, index) {
                            return ContentTemplate(
                                item: KDummyData.onBoardItemList[index]);
                          }),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            ...List.generate(
                              KDummyData.onBoardItemList.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                                height: 8,
                                width: selectedIndex == index ? 24 : 8,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? const Color(0xFF6BCCC9)
                                        : const Color(0xFF757B7B),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            if (selectedIndex <
                                KDummyData.onBoardItemList.length - 1) {
                              controller.animateToPage(selectedIndex + 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            } else {
                              await completeOnboarding();
                              Get.offAll(() =>
                                  FirebaseAuth.instance.currentUser != null
                                      ? const MyBottomNavBar()
                                      : const LoginScreen());
                            }
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: const Color(0xFF6BCCC9), width: 1),
                              color: Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xFF6BCCC9),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentTemplate extends StatelessWidget {
  const ContentTemplate({
    super.key,
    required this.item,
  });

  final OnBoardItems item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          item.image,
          width: size.width * 0.898,
        ),
        SizedBox(height: size.height * 0.05),
        RichText(
          text: TextSpan(
            text: item.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF424242),
              fontFamily: 'Poppins',
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        RichText(
          text: TextSpan(
            text: item.shortDescription,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Color(0xFF757B7B),
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(height: size.height * 0.05),
      ],
    );
  }
}

class OnBoardItems {
  final String image;
  final String title;
  final String shortDescription;
  OnBoardItems({
    required this.image,
    required this.title,
    required this.shortDescription,
  });

  OnBoardItems copyWith({
    String? image,
    String? title,
    String? shortDescription,
  }) {
    return OnBoardItems(
      image: image ?? this.image,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'shortDescription': shortDescription,
    };
  }

  factory OnBoardItems.fromMap(Map<String, dynamic> map) {
    return OnBoardItems(
      image: map['image'] as String,
      title: map['title'] as String,
      shortDescription: map['shortDescription'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnBoardItems.fromJson(String source) =>
      OnBoardItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OnBoardItems(image: $image, title: $title, shortDescription: $shortDescription)';

  @override
  bool operator ==(covariant OnBoardItems other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.title == title &&
        other.shortDescription == shortDescription;
  }

  @override
  int get hashCode =>
      image.hashCode ^ title.hashCode ^ shortDescription.hashCode;
}

class KDummyData {
  static List<OnBoardItems> onBoardItemList = [
    OnBoardItems(
      image: 'assets/images/Onboarding1.png',
      title: "Beragam pilihan",
      shortDescription:
          "Dapatkan produk terbaik di e-commerce kami dengan penawaran eksklusif yang tidak akan Anda temukan di tempat lain!",
    ),
    OnBoardItems(
      image: 'assets/images/Onboarding2.png',
      title: "Pembayaran mudah",
      shortDescription:
          "Kami mendukung berbagai metode pembayaran, bayar dengan metode pembayaran yang paling nyaman bagi Anda!",
    )
  ];
}

class AppColors {
  Color get primaryColor => const Color(0xffFFBB38);
  Color get textColor => const Color(0xff1D1D1D);
  Color get textGreyColor => const Color(0xff797979);
  Color get gray_100 => Colors.grey[500]!;
  Color get paragraphColor => const Color(0xff18587A);
}

AppColors get appColor => AppColors();
