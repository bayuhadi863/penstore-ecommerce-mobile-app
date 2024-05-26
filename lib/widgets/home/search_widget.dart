import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/product/products_controller.dart';
import 'package:penstore/widgets/text_form_field.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: mediaQueryWidth * 0.730,
            child: CustomTextField(
              focusNode: productController.searchFocusNode,
              hintText: "Cari barang apa?",
              prefixIcon: 'search',
              keyboardType: TextInputType.text,
              controller: productController.searchTextController,
            ),
          ),
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF6BCCC9),
              borderRadius: BorderRadius.circular(50),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF91E0DD).withOpacity(0.8),
                  blurRadius: 16,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/option.png',
                height: 24,
                width: 24,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
