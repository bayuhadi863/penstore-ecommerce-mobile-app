import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/get_carts_controller.dart';
import 'package:penstore/controller/cart/get_user_cart_by_seller_controller.dart';
import 'package:penstore/controller/cart/select_cart_controller.dart';
import 'package:penstore/controller/cart/update_quantity_cart_controller.dart';
import 'package:penstore/controller/profile/get_single_user_controller.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/models/cart_model.dart';
import 'package:penstore/repository/cart_repository.dart';
import 'package:penstore/screens/cart/order_screen.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/cart/appBar_cart_widget.dart';
import 'package:skeletons/skeletons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 0;
  bool isAddButtonPressed = false;
  bool isRemoveButtonPressed = false;
  bool isCheckedAll = false;
  int total = 1000000;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     quantity = getCartsController.carts.length;
  //   });
  // }

  // function to format int to Rupiah Currency
  String formatRupiah(int number) {
    final numberString = number.toString();
    String result = '';
    for (int i = 0; i < numberString.length; i++) {
      if (i % 3 == 0 && i != 0) {
        result = '.$result';
      }
      result = numberString[numberString.length - i - 1] + result;
    }
    return 'Rp$result';
  }

  void _onCheckedAllChanged(bool? value) {
    setState(() {
      isCheckedAll = value ?? false;
      _isCheckedList.fillRange(0, _isCheckedList.length, isCheckedAll);
    });
  }

  final List<bool> _isCheckedList = List.generate(10, (index) => false);
  final List<int> quantityList = List.generate(10, (index) => 0);

  void _onChanged(int index, bool value) {
    setState(() {
      _isCheckedList[index] = value;
    });

    // print
    print('index: $index, value: $value');
  }

  //add quantity
  void addQuantity(int index) {
    setState(() {
      quantityList[index]++;
      isAddButtonPressed = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isAddButtonPressed = false;
      });
    });
  }

  //remove quantity
  void removeQuantity(int index) {
    if (quantityList[index] > 0) {
      setState(() {
        quantityList[index]--;
        isRemoveButtonPressed = true;
      });
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isRemoveButtonPressed = false;
      });
    });
  }

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final getCartsController = Get.put(GetCartsController());
    final SelectCartController selectCartController =
        Get.put(SelectCartController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // Membuat AppBar transparan
        elevation: 0,
        scrolledUnderElevation: 0, // Menghilangkan shadow pada AppBar
        title: const AppBarCartWidget(),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: mediaQueryHeight,
            width: mediaQueryWidth,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      getCartsController.cartSellerIds.length, (index) {
                    final cartSellerId =
                        getCartsController.cartSellerIds[index];

                    final getSingleUserController = Get.put(
                      GetSingleUserController(cartSellerId),
                      tag: cartSellerId
                          .toString(), // Use unique tag for each instance
                    );

                    final GetUserCartBySellerController
                        getUserCartBySellerController = Get.put(
                      GetUserCartBySellerController(cartSellerId),
                      tag: cartSellerId.toString(),
                    );

                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          bottom: index ==
                                  getCartsController.cartSellerIds.length - 1
                              ? 100
                              : 15),
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      color: const Color(0xFF91E0DD).withOpacity(0.3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Obx(() {
                                  final cartIds = getUserCartBySellerController
                                      .carts
                                      .map((e) => e.id!)
                                      .toList();

                                  // get total price of all carts
                                  final totalPrice =
                                      getUserCartBySellerController.carts
                                          .fold<int>(
                                              0,
                                              (previousValue,
                                                      element) =>
                                                  previousValue +
                                                  (element.product.price *
                                                      element.quantity));

                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Checkbox(
                                          value: selectCartController
                                                  .isAllSelected.value &&
                                              selectCartController
                                                      .sellerId.value ==
                                                  cartSellerId,
                                          onChanged: (value) {
                                            selectCartController.selectAll(
                                                cartIds,
                                                totalPrice,
                                                cartSellerId);
                                          },
                                          activeColor: Colors.transparent,
                                          checkColor: const Color(0xFF6BCCC9),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      SizedBox(
                                        width: mediaQueryWidth * 0.02,
                                      ),
                                      Image.asset(
                                        'assets/icons/store_outline.png',
                                        height: 18,
                                        width: 18,
                                        filterQuality: FilterQuality.high,
                                      ),
                                      SizedBox(
                                        width: mediaQueryWidth * 0.02,
                                      ),
                                      Obx(() {
                                        final sellerName =
                                            getSingleUserController
                                                .user.value.name;

                                        return RichText(
                                          text: TextSpan(
                                            text: sellerName,
                                            style: const TextStyle(
                                              color: Color(0xFF424242),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: mediaQueryHeight * 0.02,
                          ),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color(0xFF757B7B),
                          ),
                          SizedBox(
                            height: mediaQueryHeight * 0.02,
                          ),
                          Obx(() {
                            final carts = getUserCartBySellerController.carts;
                            return Column(
                              children: List.generate(carts.length, (index) {
                                final cart = carts[index];

                                final UpdateQuantityCartController
                                    updateQuantityCartController = Get.put(
                                  UpdateQuantityCartController(cart.id!),
                                  tag: cart.id.toString(),
                                );

                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  height: 100,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
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
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF91E0DD)
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Checkbox(
                                          value: selectCartController
                                              .selectedCart
                                              .contains(cart.id),
                                          onChanged: (value) {
                                            selectCartController.selectCart(
                                                cart.id!,
                                                cart.product.price,
                                                cart.quantity,
                                                cartSellerId);
                                          },
                                          activeColor: Colors.transparent,
                                          checkColor: const Color(0xFF6BCCC9),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      SizedBox(width: mediaQueryWidth * 0.040),
                                      Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed('/detail-product');
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFF91E0DD),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                clipBehavior: Clip.hardEdge,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: (cart.product.imageUrl !=
                                                            null &&
                                                        cart.product.imageUrl!
                                                            .isNotEmpty)
                                                    ? Image.network(
                                                        cart.product.imageUrl!,
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
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            cart.product.name,
                                            style: const TextStyle(
                                              color: Color(0xFF424242),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Text(
                                            Format.formatRupiah(
                                                cart.product.price),
                                            style: const TextStyle(
                                              color: Color(0xFF91E0DD),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Container(
                                            width: mediaQueryWidth * 0.259,
                                            height: mediaQueryHeight * 0.038,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                color: const Color(0xFFB3B3B3),
                                              ),
                                            ),
                                            child: Obx(() {
                                              final quantity =
                                                  updateQuantityCartController
                                                      .quantity.value;
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      updateQuantityCartController
                                                          .increment(cart.id!);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 18,
                                                      color: quantity <
                                                              cart.product.stock
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
                                                    onTap: () async {
                                                      updateQuantityCartController
                                                          .decrement(cart.id!);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                      color: quantity > 1
                                                          ? Colors.red[300]
                                                          : const Color(
                                                              0xFFB3B3B3),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          }),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Obx(
            () => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: mediaQueryWidth * 0.9,
                height: mediaQueryHeight * 0.088,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF91E0DD).withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(1, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: mediaQueryWidth * 0.351,
                      height: mediaQueryHeight * 0.048,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: const Color(0xFF6BCCC9),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          formatRupiah(selectCartController.totalPrice.value),
                          style: const TextStyle(
                            color: Color(0xFF6BCCC9),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          // width: mediaQueryWidth * 0.251,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          height: mediaQueryHeight * 0.048,
                          decoration: BoxDecoration(
                            color: selectCartController.selectedCart.isEmpty
                                ? Colors.grey[400]
                                : Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (selectCartController.selectedCart.isEmpty) {
                                return;
                              }

                              Get.to(
                                () => CheckoutScreen(
                                  totalPrice:
                                      selectCartController.totalPrice.value,
                                  cartIds: selectCartController.selectedCart
                                      .toList(),
                                ),
                              );
                            },
                            child: const Text(
                              'Hapus',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          // width: mediaQueryWidth * 0.251,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          height: mediaQueryHeight * 0.048,
                          decoration: BoxDecoration(
                            color: selectCartController.selectedCart.isEmpty
                                ? Colors.grey[400]
                                : const Color(0xFF6BCCC9),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (selectCartController.selectedCart.isEmpty) {
                                return;
                              }

                              Get.to(
                                () => CheckoutScreen(
                                  totalPrice:
                                      selectCartController.totalPrice.value,
                                  cartIds: selectCartController.selectedCart
                                      .toList(),
                                ),
                              );
                            },
                            child: const Text(
                              'Periksa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
