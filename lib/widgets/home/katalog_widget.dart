import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/product/products_controller.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/repository/category_repository.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletons/skeletons.dart';

class KatalogWidget extends StatefulWidget {
  const KatalogWidget({super.key});

  @override
  State<KatalogWidget> createState() => _KatalogWidgetState();
}

class _KatalogWidgetState extends State<KatalogWidget> {
  final ProductController productController = Get.put(ProductController());
  List<CategoryModel> categories = [];
  bool isLoading = false;

  Future<void> _getCategories() async {
    setState(() {
      isLoading = true;
    });

    final CategoryRepository categoryRepository = CategoryRepository();
    final List<CategoryModel> _categories =
        await categoryRepository.getCategories();

    if (mounted) {
      setState(() {
        categories =
            [CategoryModel(id: '0', category_name: 'Semua')] + _categories;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: isLoading
          ? Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SkeletonItem(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 32,
                        width: 90,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : categories.isEmpty
              ? const Text("data tidak ada")
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          CategoryModel category = categories[index];
                          final bool isActive =
                              productController.selectedCategory.value ==
                                  category.id;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                productController.setSelectedCategory(
                                    category.id == '0'
                                        ? '0'
                                        : category.id.toString());
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 30),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: isActive
                                  ? BoxDecoration(
                                      color: const Color(0xFF6BCCC9),
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: const Color(0xFF6BCCC9),
                                        width: 1,
                                      ),
                                    )
                                  : BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: const Color(0xFFB3B3B3),
                                        width: 1,
                                      ),
                                    ),
                              child: Center(
                                child: Text(
                                  category.category_name,
                                  style: isActive
                                      ? const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins',
                                        )
                                      : const TextStyle(
                                          color: Color(0xFF757B7B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins',
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                ),
    );
  }
}
