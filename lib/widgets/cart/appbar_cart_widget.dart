import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/get_carts_controller.dart';

class AppBarCartWidget extends StatelessWidget {
  const AppBarCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //icon menu
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
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
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: Color(0xFF6BCCC9),
                ),
              ),
            ),

            Container(
              width: mediaQueryWidth * 0.60,
              height: mediaQueryHeight * 0.055,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Keranjang Saya',
                        style: TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
