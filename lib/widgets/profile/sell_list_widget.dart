import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';

class SellListProfile extends StatefulWidget {
  const SellListProfile({super.key});

  @override
  State<SellListProfile> createState() => _SellListProfileState();
}

class _SellListProfileState extends State<SellListProfile> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: mediaQueryWidth,
      child: Column(
        children: List.generate(
          12,
          (index) {
            return Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 10),
              child: Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                child: Row(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed('/detail-product');
                          },
                          child: Container(
                            width: 80,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(12),
                              child: Image(
                                filterQuality: FilterQuality.high,
                                image: AssetImage(
                                  imgList[0],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Buku Tulis",
                                style: TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                width: 230,
                                child: Text(
                                  "Buku digunakan untuk merekam catatan atau memo, untuk sehari-hari....",
                                  style: TextStyle(
                                    color: Color(0xFF757B7B),
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Poppins',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Rp 10.000, -',
                                style: TextStyle(
                                  color: Color(0xFF91E0DD),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 26,
                                    height: 26,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF91E0DD)
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/icons/edit_icon.png',
                                        height: 16,
                                        width: 16,
                                        filterQuality: FilterQuality.high,
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Container(
                                    width: 26,
                                    height: 26,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF46B69)
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/icons/delete_icon.png',
                                        height: 16,
                                        width: 16,
                                        filterQuality: FilterQuality.high,
                                      ),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
