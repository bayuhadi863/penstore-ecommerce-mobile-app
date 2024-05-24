import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/wishlist/wishlist_controller.dart';
import 'package:penstore/widgets/add_kategori_wishlist.dart';
import 'package:penstore/widgets/wishlist/appbar_wishlist_widget.dart';
import 'package:penstore/models/wishlist_model.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistController wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    super.initState();
    wishlistController.getAllWishlist();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

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
              Obx(() {
                if (wishlistController.isLoading.value) {
                  return const Center(child: const CircularProgressIndicator());
                } else if (wishlistController.wishlist.isEmpty) {
                  return const Center(child: Text('No Wishlist Found'));
                } else {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...wishlistController.wishlist
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        WishlistModel wishlistItem = entry.value;
                        return _buildWishlistItem(
                          context,
                          mediaQueryHeight,
                          wishlistItem,
                          wishlistController.wishlistImage[index],
                        );
                      }).toList(),
                      _buildAddNewCollection(),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWishlistItem(BuildContext context, double mediaQueryHeight,
      WishlistModel wishlistItem, String imageUrl) {
    return Container(
      height: mediaQueryHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed('/detail-wishlist');
            },
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    height: 150, // Atur tinggi gambar sesuai kebutuhan
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/gambar_wishlist.png',
                    height: 150, // Atur tinggi gambar sesuai kebutuhan
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 5),
          Text(
            wishlistItem.name,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Color(0xFF424242),
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "${wishlistItem.products!.length} barang",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Color(0xFF424242),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewCollection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DottedBorder(
          color: const Color(0xFF6BCCC9),
          strokeWidth: 1,
          borderType: BorderType.RRect,
          dashPattern: const [7, 7],
          strokeCap: StrokeCap.butt,
          radius: const Radius.circular(12),
          borderPadding: const EdgeInsets.all(1.0),
          child: InkWell(
            onTap: () {
              Get.dialog(const AddKategoriWishlistWidget());
            },
            child: SizedBox(
              width: double.infinity,
              height: 168,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Koleksi Baru',
                      style: TextStyle(
                        color: Color(0xFF757B7B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: const Color(0xFF91E0DD)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFF91E0DD),
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
