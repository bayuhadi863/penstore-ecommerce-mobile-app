import 'package:flutter/cupertino.dart';

class NoProductSell extends StatelessWidget {
  const NoProductSell({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
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
                    text: "Maaf, ",
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextSpan(
                    text: "Belum ada produk",
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
                text: "Silahkan tambahkan produk anda",
                style: TextStyle(
                  color: Color(0xFF605B57),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                )
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
