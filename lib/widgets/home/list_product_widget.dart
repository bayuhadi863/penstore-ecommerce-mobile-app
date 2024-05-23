import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/add_cart_controller.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/product_repository.dart';
import 'package:penstore/widgets/home/add_collection_dialog_widget.dart';
import 'package:skeletons/skeletons.dart';

class ListProductWidget extends StatefulWidget {
  final String? selectedCategory;

  const ListProductWidget({super.key, required this.selectedCategory});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  List<ProductModel> products = [];
  bool isLoading = false;

  Future<void> _getProducts() async {
    print("ambil semua data");
    setState(() {
      isLoading = true;
    });

    final ProductRepository productRepository = ProductRepository();
    final List<ProductModel> _products =
        await productRepository.getAllProducts();
    setState(() {
      products = _products;
      isLoading = false;
    });
  }

  Future<void> _getProductsByCategory() async {
    print("ambil data tertentu");
    setState(() {
      isLoading = true;
    });

    final ProductRepository productRepository = ProductRepository();
    final List<ProductModel> _products = await productRepository
        .getProductsByCategoryId(widget.selectedCategory! as String);
    setState(() {
      products = _products;
      isLoading = false;
    });
  }

  // mengecek apakah categoryId berubah
  @override
  void didUpdateWidget(covariant ListProductWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategory != oldWidget.selectedCategory) {
      if (widget.selectedCategory != '') {
        _getProductsByCategory();
      } else {
        _getProducts();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.selectedCategory != '') {
      _getProductsByCategory();
    } else {
      _getProducts();
    }
    print(products);
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final AddCartController addCartController = Get.put(AddCartController());

    return Column(children: [
      isLoading
          ? SkeletonItem(
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
            )
          : products.isEmpty
              ? const Text("data tidak ada")
              : ListView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    ProductModel product = products[index];
                    return Container(
                      width: double.infinity,
                      height: 100, 
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed('/detail-product',
                                  arguments: {'productId': product.id});
                            },
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF91E0DD)
                                        .withOpacity(0.3),
                                    blurRadius: 16,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: (product.imageUrl != null &&
                                                  product.imageUrl!.isNotEmpty)
                                              ? Image.network(
                                                  product.imageUrl!,
                                                  height: 16,
                                                  width: 16,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/icons/cart_outline.png',
                                                  height: 16,
                                                  width: 16,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const AddCollectionDialog();
                                              },
                                            );
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset(
                                              isFavorite
                                                  ? 'assets/icons/favorite_fill.png'
                                                  : 'assets/icons/favorite_outline.png',
                                              height: 13,
                                              width: 13,
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                color: Color(0xFF424242),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 230,
                                              child: Text(
                                                product.desc,
                                                style: const TextStyle(
                                                  color: Color(0xFF757B7B),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Poppins',
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Rp ${product.price} -',
                                              style: const TextStyle(
                                                color: Color(0xFF91E0DD),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                addCartController.createCart(
                                    userController.user.value,
                                    product,
                                    1,
                                    context);
                              },
                              child: Container(
                                width: 26,
                                height: 26,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Image.asset(
                                  'assets/icons/cart_outline.png',
                                  height: 16,
                                  width: 16,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
    ]);
  }
}
