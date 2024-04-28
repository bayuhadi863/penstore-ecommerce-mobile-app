import 'package:flutter/material.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/repository/category_repository.dart';

class KatalogWidget extends StatefulWidget {
  final Function onCategorySelected;

  const KatalogWidget({super.key, required this.onCategorySelected});

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
      categories =  [CategoryModel(id: 'semua', category_name: 'Semua')] + _categories;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 32,
        child: isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              )
            : categories.isEmpty
                ? const Text("data tidak ada")
                : ListView.builder(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      CategoryModel category = categories[index];
                      final bool isActive = _selectedCategory == index;

                      return GestureDetector(
                        onTap: () {
                          print("tekan category");
                          setState(() {
                            _selectedCategory = index;
                            widget.onCategorySelected(category.id == 'semua' ? '' : category.id);
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
    );
  }
}
