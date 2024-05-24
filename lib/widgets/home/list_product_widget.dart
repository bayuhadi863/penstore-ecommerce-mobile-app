import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/product/products_controller.dart';

import 'package:penstore/models/product_model.dart';
import 'package:penstore/widgets/home/product_item_widget.dart';
import 'package:penstore/widgets/no_product.dart';
import 'package:skeletons/skeletons.dart';

class ListProductWidget extends StatelessWidget {
  final String? selectedCategory;

  const ListProductWidget({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      productController.setSelectedCategory(selectedCategory!);
    }

    return Obx(() {
      if (productController.isLoading.value) {
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
      } else if (productController.products.isEmpty) {
        return const NoProduct();
      } else {
        return ListView.builder(
          itemCount: productController.products.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            ProductModel product = productController.products[index];
            return ProductItemWidget(
              product: product,
            );
          },
        );
      }
    });
  }
}
