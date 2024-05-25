import 'package:flutter/material.dart';
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
  String categoryId = '';

  final FocusNode _searchFocusNode = FocusNode();
  bool isFavorite = false;

  // set ubah category
  Future<void> _setCategory(String? categoryId) async {
    if (categoryId != null) {
      setState(() {
        this.categoryId = categoryId;
      });
      print("category ganti");
    } else {
      setState(() {
        this.categoryId = '';
      });
    }
  }

  @override 
  void initState() {
    super.initState();
    _setCategory;
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
        child: Column(
          children: [
            // widget search
            const SearchWidget(),
            // widget katalog
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: KatalogWidget(
                onCategorySelected: _setCategory,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //widget banner slider
                    const BannerSlider(),
                    //widget list product
                    ListProductWidget(
                      selectedCategory: categoryId,
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
