import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/screens/cart/cart_screen.dart';

class AppBarChat extends StatelessWidget {
  const AppBarChat({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //icon menu
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF91E0DD),
                borderRadius: BorderRadius.circular(50),
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF91E0DD).withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/logo_pens.png',
                height: 27,
                width: 32,
                filterQuality: FilterQuality.high,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  // color: Colors.white,
                  // borderRadius: BorderRadius.circular(50),
                  // shape: BoxShape.rectangle,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: const Color(0xFF91E0DD).withOpacity(0.3),
                  //     blurRadius: 16,
                  //     offset: const Offset(1, 1),
                  //   ),
                  // ],
                  ),
              width: mediaQueryWidth * 0.60,
              height: mediaQueryHeight * 0.055,
              child: Center(
                child: Text(
                  'Chat',
                  // authUser!.uid,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF91E0DD).withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  // navigate to cart screen
                  Get.to(() => const CartScreen());
                  // userController
                  //     .getCurrentUser(userController.currentUser!.uid);
                },
                icon: Image.asset(
                  'assets/icons/cart_outline.png',
                  height: 24,
                  width: 24,
                  filterQuality: FilterQuality.high,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
