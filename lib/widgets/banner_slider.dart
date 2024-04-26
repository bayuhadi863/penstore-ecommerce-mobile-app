import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/images/banner1.jpg',
  'assets/images/banner2.jpg',
];

class ImageSliderDemo extends StatelessWidget {
  const ImageSliderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image slider demo')),
      body: Container(
          child: CarouselSlider(
        options: CarouselOptions(),
        items: imgList
            .map((item) => Center(
                child:
                    Image.network(item, fit: BoxFit.cover, width: 1000)))
            .toList(),
      )),
    );
  }
}