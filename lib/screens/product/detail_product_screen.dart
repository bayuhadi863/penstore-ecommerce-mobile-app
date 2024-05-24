import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/add_cart_controller.dart';
import 'package:penstore/controller/product/product_controller.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/controller/wishlist/add_product_wishlist_controller.dart';
import 'package:penstore/widgets/home/add_collection_dialog_widget.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final OneProductController oneProductController =
      Get.put(OneProductController());
  final UserController userController = Get.put(UserController());
  final AddCartController addCartController = Get.put(AddCartController());
  final AddProductWishlistController addWishlistController =
      Get.put(AddProductWishlistController());

  bool _isWishlist = false;
  String? productId = '';

  //quantity
  int quantity = 0;
  bool isAddButtonPressed = false;
  bool isRemoveButtonPressed = false;

  //add quantity
  void addQuantity() {
    if (quantity >= oneProductController.product.value.stock) {
      return;
    }
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

  Future<void> checkWishlist() async {
    bool isWishlist = await addWishlistController
        .checkWishlist(oneProductController.product.value.id);
    setState(() {
      _isWishlist = isWishlist;
    });
  }

  @override
  void initState() {
    super.initState();
    // Mendapatkan nilai parameter saat widget diinisialisasi
    final Map<String, dynamic> arguments = Get.arguments;
    productId = arguments['productId'];

    oneProductController.getDetailProduct(productId!);
    checkWishlist();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    List<Widget> generateProductContainers() {
      return List.generate(10, (index) {
        return Container(
          width: mediaQueryWidth * 0.9,
          height: 69,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                color: const Color(0xFF6BCCC9).withOpacity(0.3),
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 49,
                    height: 49,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        filterQuality: FilterQuality.high,
                        image: AssetImage(imgList[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    children: [
                      Text(
                        'Bintang Ardana',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF424242),
                        ),
                      ),
                      Text(
                        'Barang bagus asli',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF424242),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(0xFFFFC701),
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFFFC701),
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFFFC701),
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFFFC701),
                      size: 16,
                    ),
                    Icon(
                      Icons.star_border_outlined,
                      color: Color(0xFFFFC701),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    }

    return Obx(() {
      if (oneProductController.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          ),
        );
      } else {
        return oneProductController.product.isBlank!
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
                              onPressed: () async {
                                if (_isWishlist) {
                                  // jika sudah langsung hapus
                                  await addWishlistController
                                      .removeFromWishlist(oneProductController
                                          .product.value.id);
                                  setState(() {
                                    checkWishlist();
                                  });
                                } else {
                                  // jika belum maka pop up tambahkan ke wishlist
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AddCollectionDialog(
                                        productId: oneProductController
                                            .product.value.id,
                                      );
                                    },
                                  );
                                  setState(() {
                                    checkWishlist();
                                  });
                                }
                              },
                              icon: Image.asset(
                                _isWishlist
                                    ? 'assets/icons/favorite_fill.png'
                                    : 'assets/icons/favorite_outline.png',
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
                          child: (oneProductController.product.value.imageUrl !=
                                      [] &&
                                  oneProductController
                                      .product.value.imageUrl!.isNotEmpty)
                              ? PageView.builder(
                                  itemCount: oneProductController
                                      .product.value.imageUrl!.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      oneProductController
                                          .product.value.imageUrl![index],
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.medium,
                                    );
                                  },
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
                                        // height: mediaQueryHeight * 0.074,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
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
                                            Expanded(
                                              child: Text(
                                                oneProductController
                                                    .product.value.name,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF424242),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Rp.${oneProductController.product.value.price} -',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF6BCCC9),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: mediaQueryHeight * 0.02),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
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
                                                    'Stock: ${oneProductController.product.value.stock}',
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
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            width: mediaQueryWidth,
                                            height: mediaQueryHeight * 0.46,
                                            child: SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0),
                                                    child: Text(
                                                      oneProductController
                                                          .productCategory
                                                          .value
                                                          .category_name,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF757B7B),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0),
                                                    child: Text(
                                                      "Penjual: ${oneProductController.seller.value.name}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF757B7B),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0),
                                                    child: Text(
                                                      oneProductController
                                                          .product.value.desc,
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF757B7B),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  ...generateProductContainers(),
                                                  const SizedBox(height: 100),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              oneProductController.seller.value.id ==
                                      userController.user.value.id
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        height: mediaQueryHeight * 0.088,
                                        width: mediaQueryWidth * 0.9,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                                  color:
                                                      const Color(0xFFB3B3B3),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: addQuantity,
                                                    onTapDown: (_) {
                                                      setState(() {
                                                        isAddButtonPressed =
                                                            true;
                                                      });
                                                    },
                                                    onTapUp: (_) {
                                                      setState(() {
                                                        isAddButtonPressed =
                                                            false;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 18,
                                                      color: isAddButtonPressed
                                                          ? const Color(
                                                              0xFF6BCCC9)
                                                          : const Color(
                                                              0xFFB3B3B3),
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
                                                        isRemoveButtonPressed =
                                                            true;
                                                      });
                                                    },
                                                    onTapUp: (_) {
                                                      setState(() {
                                                        isRemoveButtonPressed =
                                                            false;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                      color:
                                                          isRemoveButtonPressed
                                                              ? const Color(
                                                                  0xFF6BCCC9)
                                                              : const Color(
                                                                  0xFFB3B3B3),
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
                                                height:
                                                    mediaQueryHeight * 0.048,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF6BCCC9),
                                                  ),
                                                ),
                                                child: Image.asset(
                                                  'assets/icons/chat_fill.png',
                                                  height: 24,
                                                  width: 24,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  color:
                                                      const Color(0xFF6BCCC9),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                addCartController.createCart(
                                                    userController.user.value,
                                                    oneProductController
                                                        .product.value,
                                                    quantity,
                                                    context);
                                              },
                                              child: Container(
                                                width: mediaQueryWidth * 0.328,
                                                height:
                                                    mediaQueryHeight * 0.048,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF6BCCC9),
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
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
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
    });
  }
}
