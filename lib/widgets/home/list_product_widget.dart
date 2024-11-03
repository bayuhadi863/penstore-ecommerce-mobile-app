import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/product/products_controller.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/widgets/home/product_item_widget.dart';
import 'package:penstore/widgets/no_product.dart';
import 'package:skeletons/skeletons.dart';

class ListProductWidget extends StatelessWidget {
  const ListProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

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
        final products = productController.products;

        // sort by name
        products.sort((a, b) => a.name.compareTo(b.name));
        return ListView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            ProductModel product = products[index];

            if (product.stock == 0) {
              return const SizedBox();
            } else {
              return ProductItemWidget(
                product: product,
              );
            }
          },
        );
      }
    });
  }
}
