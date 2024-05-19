import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/screens/cart/cart_screen.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final userController = Get.put(UserController());

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
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xFF91E0DD),
                  ),
                ),
                onPressed: () {
                  // Navigator.pop(context);
                },
                icon: Image.asset(
                  'assets/images/logo_pens.png',
                  height: 27,
                  width: 32,
                  filterQuality: FilterQuality.high,
                ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF757B7B),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Obx(
                    () => Text(
                      userController.user.value.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF424242),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
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
