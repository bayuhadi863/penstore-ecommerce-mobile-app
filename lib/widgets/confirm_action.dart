import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/auth/logout_controller.dart';

class ConfirmAction extends StatelessWidget {
  const ConfirmAction({
    super.key,
    required this.title,
    required this.messageTitle,
    required this.message,
    required this.onPressed,
  });

  final String title;
  final String messageTitle;
  final String message;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      titlePadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      contentPadding: const EdgeInsets.all(20),
      surfaceTintColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: SizedBox(
        // color: const Color(0xFF91E0DD),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/wishlist_outline.png',
                  height: 32,
                  width: 32,
                  filterQuality: FilterQuality.high,
                  color: const Color(0xFFF46B69),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF46B69).withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(1, 1),
                        ),
                      ]),
                  child: Image.asset(
                    'assets/icons/close_fill.png',
                    height: 24,
                    width: 24,
                    color: const Color(
                      0xFFF46B69,
                    ),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      content: SizedBox(
        width: mediaQueryWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/confirm_logout.png',
              height: 152,
              width: 152,
              filterQuality: FilterQuality.high,
            ),
            RichText(
              text: TextSpan(
                text: messageTitle,
                style: const TextStyle(
                  color: Color(0xFF424242),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              textAlign: TextAlign.center,
            ),
            RichText(
              text: TextSpan(
                text: message,
                style: const TextStyle(
                  color: Color(0xFF605B57),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF46B69),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF46B69).withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(1, 1),
                        )
                      ]),
                  width: mediaQueryWidth * 0.38,
                  height: 54,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // setState(() {
                      //   isExpired = true;
                      // });
                      Get.back();
                    },
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                            text: 'Tidak',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 14,
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: const Color(0xFFF46B69), width: 1),
                  ),
                  width: mediaQueryWidth * 0.38,
                  height: 54,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          text: 'Ya',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xFFF46B69),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
