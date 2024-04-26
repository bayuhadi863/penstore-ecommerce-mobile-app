import 'package:flutter/material.dart';
import 'package:penstore/widgets/home/appbar_home.dart';
import 'package:penstore/widgets/home/banner_slider.dart';
import 'package:penstore/widgets/home/katalog_widget.dart';
import 'package:penstore/widgets/home/list_product_widget.dart';
import 'package:penstore/widgets/home/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  bool isFavorite = false;

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 74,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const AppBarHome(),
      ),
      body: SizedBox(
        height: mediaQueryHeight,
        width: mediaQueryWidth,
        // color: const Color(0xFF6BCCC9),
        child: const Column(
          children: [
            // widget search
            SearchWidget(),
            // widget katalog
            KatalogWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //widget banner slider
                    BannerSlider(),
                    //widget list product
                    ListProductWidget(),
                    SizedBox(
                      height: 100,
                    ),
                  ], 
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}