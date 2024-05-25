import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

final List<String> imgList = [
  'assets/images/banner_slider1.png',
  'assets/images/banner_slider2.png',
  'assets/images/banner_slider3.png',
];

final List<String> titles = [
  'Temukan ',
  'Nikmati ',
  'Belanja sekarang ',
];

final List<String> subtitles = [
  'produk',
  'kemudahan',
  'dan',
];

final List<String> descriptions = [
  'terbaru dan terlengkap',
  'berbelanja di toko online',
  'rasakan pengalamannya',
];

final List<String> urls = [
  'Terbaru',
  'Kemudahan',
  'Terbaik',
];

class _BannerSliderState extends State<BannerSlider> {
  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: mediaQueryHeight * 0.220,
          margin: const EdgeInsets.only(top: 0, bottom: 10),
          width: mediaQueryWidth,
          child: CarouselSlider(
            options: CarouselOptions(
              height: mediaQueryHeight * 0.220,
              clipBehavior: Clip.antiAlias,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentSlide = index;
                });
              },
            ),
            items: imgList.asMap().entries.map((entry) {
              int index = entry.key;
              String item = entry.value;
              return Stack(
                children: [
                  Container(
                    width: 307,
                    height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF91E0DD).withOpacity(0.5),
                          blurRadius: 16,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        filterQuality: FilterQuality.high,
                        image: AssetImage(
                          item,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // Text on bottom left
                  Positioned(
                    bottom: 24,
                    left: 15,
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: urls[index],
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Icon panah
                        Image.asset(
                          'assets/icons/arrow.png',
                          color: const Color(0xFFFFFFFF),
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 22,
                    left: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: titles[index],
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: subtitles[index],
                                style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: descriptions[index],
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF91E0DD).withOpacity(0.1),
                ),
                child: Container(
                  width: 20,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: _currentSlide == index
                        ? const Color(0xFF6BCCC9)
                        : const Color(0xFF91E0DD).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
