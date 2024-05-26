import 'package:flutter/material.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/repository/category_repository.dart';
import 'package:skeletons/skeletons.dart';

class KatalogWidget extends StatefulWidget {
  final Function onCategorySelected;

  const KatalogWidget({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  State<KatalogWidget> createState() => _KatalogWidgetState();
}

class _KatalogWidgetState extends State<KatalogWidget> {
  List<CategoryModel> categories = [];
  bool isLoading = false;
  int _selectedCategory = 0;

  Future<void> _getCategories() async {
    setState(() {
      isLoading = true;
    });

    final CategoryRepository categoryRepository = CategoryRepository();
    final List<CategoryModel> _categories =
        await categoryRepository.getCategories();
    setState(() {
      categories =
          [CategoryModel(id: 'semua', category_name: 'Semua')] + _categories;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  Widget _buildSkeletonItem() {
    return SkeletonItem(
      child: Container(
        margin: const EdgeInsets.only(left: 30),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: const Color(0xFFB3B3B3),
            width: 1,
          ),
        ),
        child: SkeletonLine(
          style: SkeletonLineStyle(
            height: 10,
            width: 80,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: isLoading
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  6,
                  (index) => _buildSkeletonItem(),
                ),
              ),
            )
          : categories.isEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: const Color(0xFFB3B3B3),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          "data tidak ada",
                          style: TextStyle(
                            color: Color(0xFF757B7B),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      categories.length,
                      (index) {
                        CategoryModel category = categories[index];
                        final bool isActive = _selectedCategory == index;
                        return GestureDetector(
                          onTap: () {
                            print("tekan category");
                            setState(() {
                              _selectedCategory = index;
                              widget.onCategorySelected(
                                category.id == 'semua' ? 'semua' : category.id,
                              );
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 30),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  ),
                ),
    );
  }
}
