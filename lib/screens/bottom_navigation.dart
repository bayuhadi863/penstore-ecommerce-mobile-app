import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:penstore/screens/chat/chat_screen.dart';
import 'package:penstore/screens/home_screen.dart';
import 'package:penstore/screens/profile/profile_screen.dart';
import 'package:penstore/screens/wishlist/wishlist_screen.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = const [
      HomeScreen(),
      WishlistScreen(),
      ChatScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF91E0DD).withOpacity(0.5),
                blurRadius: 16,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    myCurrentIndex = 0;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: myCurrentIndex == 0
                        ? const Color(0xFF6BCCC9)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icons/home.png',
                    height: 24,
                    width: 24,
                    color: myCurrentIndex == 0
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF757B7B),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    myCurrentIndex = 1;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: myCurrentIndex == 1
                        ? const Color(0xFF6BCCC9)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icons/favorite.png',
                    height: 24,
                    width: 24,
                    color: myCurrentIndex == 1
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF757B7B),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    myCurrentIndex = 2;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: myCurrentIndex == 2
                        ? const Color(0xFF6BCCC9)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icons/chat.png',
                    height: 24,
                    width: 24,
                    color: myCurrentIndex == 2
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF757B7B),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    myCurrentIndex = 3;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: myCurrentIndex == 3
                        ? const Color(0xFF6BCCC9)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icons/user2.png',
                    height: 24,
                    width: 24,
                    color: myCurrentIndex == 3
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF757B7B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: pages[myCurrentIndex],
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
    );
  }
}