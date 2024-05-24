import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';
import 'package:penstore/widgets/wishlist/appbar_wishlist_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final int itemCount = 10; // Number of initial items
    final List<Widget> gridItems = List.generate(
      itemCount,
      (index) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 179,
              width: 179,
              child: Image.asset(
                'assets/images/semua.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            )
          ],
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const AppBarHome(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  ...gridItems,
                  DottedBorder(
                    color: const Color(0xFF91E0DD),
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12.0),
                    dashPattern: [6, 3],
                    child: Container(
                      width: (mediaQueryWidth - 60) /
                          2, // Adjust width to match grid items
                      height: 170,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Koleksi Baru',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: const Color(0xFF91E0DD)),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(Icons.add,
                                  color: Color(0xFF91E0DD), size: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: WishlistScreen()));
}
