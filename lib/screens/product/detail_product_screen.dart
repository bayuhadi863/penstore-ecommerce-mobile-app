import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/add_cart_controller.dart';
import 'package:penstore/controller/chat/room_chat_controller.dart';
import 'package:penstore/controller/product/product_controller.dart';
import 'package:penstore/controller/profile/get_single_user_controller.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/controller/rating/get_product_rating_controller.dart';
import 'package:penstore/controller/wishlist/add_product_wishlist_controller.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/models/roomChat_model.dart';
import 'package:penstore/widgets/home/add_collection_dialog_widget.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:intl/intl.dart';

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

  // PAGINATION PAGE VIEW
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

    final GetProductRatingController getProductRatingController =
        Get.put(GetProductRatingController(productId!));

    Widget generateProductContainers() {
      return Obx(() {
        final ratings = getProductRatingController.ratings;

        return ratings.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  'Belum ada penilaian.',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
              )
            : Column(
                children: List.generate(ratings.length, (index) {
                final rating = ratings[index];

                final GetSingleUserController getSingleUserController = Get.put(
                    GetSingleUserController(rating.userId),
                    tag: rating.userId);

                return Container(
                  width: mediaQueryWidth * 0.9,
                  // height: 69,
                  padding: const EdgeInsets.all(12.0),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(500),
                            // ),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(500),
                              child:
                                  getSingleUserController.user.value.imageUrl ==
                                              null ||
                                          getSingleUserController
                                                  .user.value.imageUrl ==
                                              ''
                                      ? Image(
                                          filterQuality: FilterQuality.high,
                                          image: AssetImage(imgList[0]),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          getSingleUserController
                                              .user.value.imageUrl!,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                        ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getSingleUserController.user.value.name,
                                style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF424242),
                                ),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy HH:mm')
                                    .format(rating.createdAt!),
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                rating.score >= 1
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: const Color(0xFFFFC701),
                                size: 16,
                              ),
                              Icon(
                                rating.score >= 2
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: const Color(0xFFFFC701),
                                size: 16,
                              ),
                              Icon(
                                rating.score >= 3
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: const Color(0xFFFFC701),
                                size: 16,
                              ),
                              Icon(
                                rating.score >= 4
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: const Color(0xFFFFC701),
                                size: 16,
                              ),
                              Icon(
                                rating.score >= 5
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: const Color(0xFFFFC701),
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            rating.description,
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF424242),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }));
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
                                  controller: _pageController,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      _currentPage = page;
                                    });
                                  },
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
                      Positioned(
                        top: mediaQueryHeight * 0.780 / 2 - 20,
                        left: mediaQueryWidth * 0.8,
                        right: 0,
                        child: Center(
                          child: Text(
                            "${_currentPage + 1}/${oneProductController.product.value.imageUrl!.length}",
                            style: TextStyle(
                              color: Color(0xFF6BCCC9),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
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
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              oneProductController
                                                  .product.value.name,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF424242),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  Format.formatRupiah(
                                                      oneProductController
                                                          .product.value.price),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF6BCCC9),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: mediaQueryHeight * 0.02),
                                      SizedBox(
                                        height: mediaQueryHeight * 0.40,
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // rate
                                                    Obx(() {
                                                      final averageRating =
                                                          getProductRatingController
                                                              .averageRating
                                                              .value;
                                                      return Row(
                                                        children: [
                                                          Icon(
                                                            averageRating >= 1
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border_outlined,
                                                            color: const Color(
                                                                0xFFFFC701),
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            averageRating >= 2
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border_outlined,
                                                            color: const Color(
                                                                0xFFFFC701),
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            averageRating >= 3
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border_outlined,
                                                            color: const Color(
                                                                0xFFFFC701),
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            averageRating >= 4
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border_outlined,
                                                            color: const Color(
                                                                0xFFFFC701),
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            averageRating >= 5
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border_outlined,
                                                            color: const Color(
                                                                0xFFFFC701),
                                                            size: 20,
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                    // stock
                                                    Container(
                                                      width: mediaQueryWidth *
                                                          0.30,
                                                      alignment:
                                                          Alignment.center,
                                                      height: mediaQueryHeight *
                                                          0.030,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF6BCCC9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Text(
                                                        'Stok: ${oneProductController.product.value.stock}',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFFFFFFFF),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                        child: Text(
                                                          oneProductController
                                                              .productCategory
                                                              .value
                                                              .category_name,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF757B7B),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                        child: Text(
                                                          "Penjual: ${oneProductController.seller.value.name}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF757B7B),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                        child: Text(
                                                          oneProductController
                                                              .product
                                                              .value
                                                              .desc,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF757B7B),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: Text(
                                                          "Penilaian",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF424242),
                                                          ),
                                                        ),
                                                      ),
                                                      generateProductContainers(),
                                                      const SizedBox(
                                                          height: 80),
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
                                              onTap: () async {
                                                ChatRoomController
                                                    chatRoomController =
                                                    Get.put(
                                                        ChatRoomController());
                                                await chatRoomController
                                                    .createChatRoom(
                                                        oneProductController
                                                            .seller.value.id);

                                                RoomChatModel roomChat =
                                                    await chatRoomController
                                                        .findChatRoom(
                                                            oneProductController
                                                                .seller
                                                                .value
                                                                .id);

                                                Get.toNamed('/detail-chat',
                                                    arguments: {
                                                      'roomChatId': roomChat.id,
                                                      'recieverId':
                                                          oneProductController
                                                              .seller.value.id,
                                                      'productId': productId!,
                                                    });
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
