import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/add_cart_controller.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/repository/category_repository.dart';
import 'package:penstore/repository/product_repository.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  String? productId = '';
  ProductModel? product;
  String productCategory = '';
  bool isLoading = false;

  //quantity
  int quantity = 0;
  bool isAddButtonPressed = false;
  bool isRemoveButtonPressed = false;

  //add quantity
  void addQuantity() {
    setState(() {
      quantity++;
      isAddButtonPressed = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isAddButtonPressed = false;
      });
    });
  }

  //remove quantity
  void removeQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        isRemoveButtonPressed = true;
      });
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isRemoveButtonPressed = false;
      });
    });
  }

  // get detail porduct data
  Future<void> _getDetailProduct() async {
    setState(() {
      isLoading = true;
    });
    final ProductRepository productRepository = ProductRepository();
    final _product =
        await productRepository.getProductById(productId! as String);
    String _category_name = await _getCategoryName(_product.categoryId);

    setState(() {
      product = _product;
      productCategory = _category_name;
      isLoading = false;
    });
  }

  // get product category_name
  Future<String> _getCategoryName(String categoryId) async {
    final CategoryRepository categoryRepository = CategoryRepository();
    final _category = await categoryRepository.getCategoryById(categoryId);
    return _category.category_name;
  }

  @override
  void initState() {
    super.initState();
    // Mendapatkan nilai parameter saat widget diinisialisasi
    final Map<String, dynamic> arguments = Get.arguments;
    productId = arguments['productId'];
    _getDetailProduct();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final UserController userController = Get.put(UserController());
    final AddCartController addCartController = Get.put(AddCartController());

    return isLoading
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ),
          )
        : product.isBlank == true
            ? const Text("data tidak ada")
            : Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  toolbarHeight: 74,
                  automaticallyImplyLeading: false,
                  backgroundColor:
                      Colors.transparent, // Membuat AppBar transparan
                  elevation: 0,
                  scrolledUnderElevation: 0, // Menghilangkan shadow pada AppBar
                  title: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //icon menu
                          Container(
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
                                  blurRadius: 16,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 20,
                                color: Color(0xFF6BCCC9),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mediaQueryWidth * 0.60,
                            height: mediaQueryHeight * 0.055,
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/icons/favorite_fill.png',
                                height: 24,
                                width: 24,
                                filterQuality: FilterQuality.high,
                                color: const Color(0xFF6BCCC9),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                body: Container(
                  height: mediaQueryHeight,
                  width: mediaQueryWidth,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: mediaQueryHeight * 0.438,
                          width: mediaQueryWidth,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: (product?.imageUrl != null &&
                                  product!.imageUrl!.isNotEmpty)
                              ? Image.network(
                                  product!.imageUrl!,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.medium,
                                )
                              : Image.asset(
                                  'assets/icons/cart_outline.png',
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: mediaQueryHeight * 0.6,
                          width: mediaQueryWidth,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: mediaQueryWidth,
                                        height: mediaQueryHeight * 0.074,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          color: Colors.white,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              product?.name ?? '',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF424242),
                                              ),
                                            ),
                                            Text(
                                              'Rp.${product?.price ?? ''} -',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF6BCCC9),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: mediaQueryHeight * 0.02),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // rate
                                                const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFFC701),
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFFC701),
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFFC701),
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFFC701),
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                      color: Color(0xFFFFC701),
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                                // stock
                                                Container(
                                                  width: mediaQueryWidth * 0.30,
                                                  alignment: Alignment.center,
                                                  height:
                                                      mediaQueryHeight * 0.030,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF6BCCC9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    'Stock: ${product?.stock ?? ''}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFFFFFFF),
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: mediaQueryWidth,
                                              height: mediaQueryHeight * 0.46,
                                              child: SingleChildScrollView(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      productCategory,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF757B7B),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      product?.desc ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF757B7B),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 100),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  height: mediaQueryHeight * 0.088,
                                  width: mediaQueryWidth * 0.9,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(50),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: mediaQueryWidth * 0.259,
                                        height: mediaQueryHeight * 0.048,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: const Color(0xFFB3B3B3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: addQuantity,
                                              onTapDown: (_) {
                                                setState(() {
                                                  isAddButtonPressed = true;
                                                });
                                              },
                                              onTapUp: (_) {
                                                setState(() {
                                                  isAddButtonPressed = false;
                                                });
                                              },
                                              child: Icon(
                                                Icons.add,
                                                size: 18,
                                                color: isAddButtonPressed
                                                    ? const Color(0xFF6BCCC9)
                                                    : const Color(0xFFB3B3B3),
                                              ),
                                            ),
                                            Text(
                                              quantity.toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            InkWell(
                                              onTap: removeQuantity,
                                              onTapDown: (_) {
                                                setState(() {
                                                  isRemoveButtonPressed = true;
                                                });
                                              },
                                              onTapUp: (_) {
                                                setState(() {
                                                  isRemoveButtonPressed = false;
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 18,
                                                color: isRemoveButtonPressed
                                                    ? const Color(0xFF6BCCC9)
                                                    : const Color(0xFFB3B3B3),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed('/detail-chat');
                                        },
                                        child: Container(
                                          width: mediaQueryWidth * 0.164,
                                          height: mediaQueryHeight * 0.048,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: const Color(0xFF6BCCC9),
                                            ),
                                          ),
                                          child: Image.asset(
                                            'assets/icons/chat_fill.png',
                                            height: 24,
                                            width: 24,
                                            filterQuality: FilterQuality.high,
                                            color: const Color(0xFF6BCCC9),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          addCartController.createCart(
                                              userController.user.value,
                                              product!,
                                              quantity);
                                        },
                                        child: Container(
                                          width: mediaQueryWidth * 0.328,
                                          height: mediaQueryHeight * 0.048,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6BCCC9),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Color(0xFFFFFFFF),
                                                size: 22,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Cart',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFFFFFFFF),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ));
  }
}
