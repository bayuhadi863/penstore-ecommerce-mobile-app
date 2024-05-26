import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/product/products_controller.dart';
import 'package:penstore/widgets/home/appbar_home_widget.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:penstore/widgets/home/katalog_widget.dart';
import 'package:penstore/widgets/home/list_product_widget.dart';
import 'package:penstore/widgets/home/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.put(ProductController());

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: KatalogWidget(),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //widget banner slider
                    BannerSlider(),
                    //widget list product
                    ListProductWidget(),
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