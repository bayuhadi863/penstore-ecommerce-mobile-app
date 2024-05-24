import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penstore/widgets/wishlist/appbar_detail_wishlist_widget.dart';

class WishlistDetailScreen extends StatefulWidget {
  const WishlistDetailScreen({super.key});

  @override
  State<WishlistDetailScreen> createState() => _WishlistDetailScreenState();
}

class _WishlistDetailScreenState extends State<WishlistDetailScreen> {
  final bool _isWishlist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const AppBarDetailWishlist(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: List.generate(
                10,
                (index) {
                  return Container(
                    width: double.infinity,
                    height: 100,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {},
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
                                        child: Image.asset(
                                          'assets/icons/cart_outline.png',
                                          height: 16,
                                          width: 16,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: GestureDetector(
                                        onTap: () async {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            _isWishlist
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Alat Tulis",
                                            style: const TextStyle(
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
                                              style: const TextStyle(
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
                                            'Rp 20.0000 -',
                                            style: const TextStyle(
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
