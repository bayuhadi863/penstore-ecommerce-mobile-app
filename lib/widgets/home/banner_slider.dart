import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

final List<String> imgList = [
  'assets/images/banner1.jpg',
  'assets/images/banner2.jpg',
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
          height: mediaQueryHeight * 0.209,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: mediaQueryWidth,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: mediaQueryHeight * 0.209,
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
            items: imgList
                .map((item) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 307,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF91E0DD).withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 307,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFF605B57)
                                      .withOpacity(0.12), // Set border color
                                  width: 3, // Atur lebar sesuai kebutuhan
                                ),
                              ),
                              child: ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(8),
                                child: Image(
                                  filterQuality: FilterQuality.high,
                                  image: AssetImage(
                                    item,
                                  ),
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                            //overlay
                            Center(
                              child: Container(
                                width: 281,
                                height: 132,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.16, 1],
                                    colors: [
                                      const Color(0xFF120B0B).withOpacity(0.08),
                                      const Color(0xFF120B0B).withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            // text on bottom left
                            const Positioned(
                              bottom: 12,
                              left: 12,
                              child: Row(
                                children: [
                                  Text(
                                    'Kamar Tidur',
                                    style: TextStyle(
                                      color: Color(0xFFE5E5E5),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  //icon panah
                                  Icon(
                                    Icons.arrow_forward_sharp,
                                    color: Color(0xFFE5E5E5),
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
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
