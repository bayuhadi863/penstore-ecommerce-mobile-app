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
      child: SizedBox(
        width: double.infinity,
        child: CustomTextField(
          focusNode: productController.searchFocusNode,
          hintText: "Cari barang apa?",
          prefixIcon: 'search',
          keyboardType: TextInputType.text,
          controller: productController.searchTextController,
        ),
      ),
    );
  }
}
