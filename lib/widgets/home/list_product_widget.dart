import 'package:flutter/material.dart';
import 'package:penstore/screens/auth/login_screen.dart';
import 'package:penstore/widgets/home/add_collection_dialog_widget.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({super.key});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        10,
        (index) {
          return Container(
            width: double.infinity,
            height: 100,
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.all(10),
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
                            Container(
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
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AddCollectionDialog();
                                      });
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    isFavorite
                                        ? 'assets/icons/favorite_fill.png'
                                        : 'assets/icons/favorite_outline.png',
                                    height: 13,
                                    width: 13,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pensil Staedler 2B',
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
                                      'Pensil Staedtler adalah alat tulis yang terkenal diproduksi oleh merek Staedtler. Pensil ini...',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Rp 40.000 -',
                                    style: TextStyle(
                                      color: Color(0xFF91E0DD),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF91E0DD).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Image.asset(
                        'assets/icons/cart_outline.png',
                        height: 16,
                        width: 16,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}