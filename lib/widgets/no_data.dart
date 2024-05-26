import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String title;
  final String subTitle;
  final String suggestion;

  const NoData({
    super.key,
    required this.title,
    required this.subTitle,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/no_product.png',
              height: 152,
              width: 152,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextSpan(
                    text: subTitle,
                    style: TextStyle(
                      color: Color(0xFF6BCCC9),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: suggestion,
                style: TextStyle(
                  color: Color(0xFF605B57),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
