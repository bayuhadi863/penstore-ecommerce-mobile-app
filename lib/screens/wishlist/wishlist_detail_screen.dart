import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/wishlist/product_wishlist_controller.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/widgets/home/product_item_widget.dart';
import 'package:penstore/widgets/no_product.dart';
import 'package:penstore/widgets/wishlist/appbar_detail_wishlist_widget.dart';
import 'package:skeletons/skeletons.dart';

class WishlistDetailScreen extends StatefulWidget {
  const WishlistDetailScreen({super.key});

  @override
  State<WishlistDetailScreen> createState() => _WishlistDetailScreenState();
}

class _WishlistDetailScreenState extends State<WishlistDetailScreen> {
  final ProductWishlistController productWishlistController =
      Get.put(ProductWishlistController());

  String? wishlistId;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments = Get.arguments;
    wishlistId = arguments['wishlistId'];

    productWishlistController.getWishlistProducts(wishlistId!);
  }

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
        child: Obx(() {
          if (productWishlistController.isLoading.value) {
            return SkeletonItem(
              child: Column(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: double.infinity,
                        height: 100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (productWishlistController.products.isEmpty) {
            return const NoProduct();
          } else {
            return ListView.builder(
              itemCount: productWishlistController.products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ProductModel product =
                    productWishlistController.products[index];
                return ProductItemWidget(product: product);
              },
            );
          }
        }),
      ),
    );
  }
}