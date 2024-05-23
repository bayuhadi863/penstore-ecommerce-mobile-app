import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/get_carts_controller.dart';
import 'package:penstore/controller/cart/select_cart_controller.dart';
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
  final getCartsController = Get.put(GetCartsController());
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

  final SelectCartController selectCartController =
      Get.put(SelectCartController());

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: const Color(0xFF91E0DD).withOpacity(0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Checkbox(
                                      value: isCheckedAll,
                                      onChanged: _onCheckedAllChanged,
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
                                  RichText(
                                    text: TextSpan(
                                      text: 'Thania Store',
                                      style: TextStyle(
                                        color: const Color(0xFF424242),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF91E0DD).withOpacity(0.3),
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
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Checkbox(
                                  value: isCheckedAll,
                                  onChanged: _onCheckedAllChanged,
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
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF91E0DD),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: BorderRadius.circular(12),
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
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // carts[index].product.name,
                                    "Baju Kemeja Pria",
                                    style: const TextStyle(
                                      color: Color(0xFF424242),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Text(
                                    // Format.formatRupiah(
                                    //     carts[index].product.price),
                                    "Rp. 12.000",
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
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: const Color(0xFFB3B3B3),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            // print(carts[index].id!);
                                            // setState(() {
                                            //   isAddButtonPressed =
                                            //       true;
                                            // });
                                            // try {
                                            //   await CartRepository.instance
                                            //       .addCartQuantity(
                                            //           carts[index].id!, 1);
                                            // } catch (e) {
                                            //   return;
                                            // }

                                            // setState(() {
                                            //   isAddButtonPressed =
                                            //       false;
                                            // });
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
                                          // carts[index].quantity.toString(),
                                          "12",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // print(carts[index].id!);
                                            // setState(() {
                                            //   isRemoveButtonPressed =
                                            //       true;
                                            // });
                                            // try {
                                            //   await CartRepository.instance
                                            //       .subtractCartQuantity(
                                            //           carts[index].id!, 1);
                                            // } catch (e) {
                                            //   return;
                                            // }
                                            // setState(() {
                                            //   isRemoveButtonPressed =
                                            //       false;
                                            // });
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
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryHeight * 0.02,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: const Color(0xFF91E0DD).withOpacity(0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Checkbox(
                                      value: isCheckedAll,
                                      onChanged: _onCheckedAllChanged,
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
                                  RichText(
                                    text: TextSpan(
                                      text: 'Thania Store',
                                      style: TextStyle(
                                        color: const Color(0xFF424242),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF91E0DD).withOpacity(0.3),
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
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Checkbox(
                                  value: isCheckedAll,
                                  onChanged: _onCheckedAllChanged,
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
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF91E0DD),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: BorderRadius.circular(12),
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
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // carts[index].product.name,
                                    "Baju Kemeja Pria",
                                    style: const TextStyle(
                                      color: Color(0xFF424242),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Text(
                                    // Format.formatRupiah(
                                    //     carts[index].product.price),
                                    "Rp. 12.000",
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
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: const Color(0xFFB3B3B3),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            // print(carts[index].id!);
                                            // setState(() {
                                            //   isAddButtonPressed =
                                            //       true;
                                            // });
                                            // try {
                                            //   await CartRepository.instance
                                            //       .addCartQuantity(
                                            //           carts[index].id!, 1);
                                            // } catch (e) {
                                            //   return;
                                            // }

                                            // setState(() {
                                            //   isAddButtonPressed =
                                            //       false;
                                            // });
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
                                          // carts[index].quantity.toString(),
                                          "12",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // print(carts[index].id!);
                                            // setState(() {
                                            //   isRemoveButtonPressed =
                                            //       true;
                                            // });
                                            // try {
                                            //   await CartRepository.instance
                                            //       .subtractCartQuantity(
                                            //           carts[index].id!, 1);
                                            // } catch (e) {
                                            //   return;
                                            // }
                                            // setState(() {
                                            //   isRemoveButtonPressed =
                                            //       false;
                                            // });
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
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  StreamBuilder<List<CartModel>>(
                      stream: CartRepository.instance.streamCarts(FirebaseAuth
                          .instance
                          .currentUser!
                          .uid), // Menggunakan streamCarts dari controller
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SkeletonItem(
                            child: Column(
                              children: List.generate(
                                6,
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
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Tampilkan pesan error jika terjadi kesalahan
                        } else {
                          // Render data carts jika tidak ada error dan sudah ada data
                          final carts = snapshot.data!;
                          return Column(
                            children: List.generate(
                              carts.length,
                              (index) {
                                return Container(
                                  width: double.infinity,
                                  height: 100,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 10),
                                  child: Container(
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
                                          child: Obx(
                                            () => Checkbox(
                                              value: selectCartController
                                                  .selectedCart
                                                  .contains(carts[index].id),
                                              onChanged: (value) {
                                                selectCartController.selectCart(
                                                    carts[index].id!,
                                                    carts[index].product.price,
                                                    carts[index].quantity);
                                              },
                                              activeColor: Colors.transparent,
                                              checkColor:
                                                  const Color(0xFF6BCCC9),
                                              side: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: mediaQueryWidth * 0.040),
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
                                                ),
                                                child: ClipRRect(
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: (carts[index]
                                                                  .product
                                                                  .imageUrl !=
                                                              null &&
                                                          carts[index]
                                                              .product
                                                              .imageUrl!
                                                              .isNotEmpty)
                                                      ? Image.network(
                                                          carts[index]
                                                              .product
                                                              .imageUrl!,
                                                          height: 16,
                                                          width: 16,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          'assets/icons/cart_outline.png',
                                                          height: 16,
                                                          width: 16,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
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
                                              carts[index].product.name,
                                              style: const TextStyle(
                                                color: Color(0xFF424242),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Text(
                                              Format.formatRupiah(
                                                  carts[index].product.price),
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
                                                    onTap: () async {
                                                      // print(carts[index].id!);
                                                      // setState(() {
                                                      //   isAddButtonPressed =
                                                      //       true;
                                                      // });
                                                      try {
                                                        await CartRepository
                                                            .instance
                                                            .addCartQuantity(
                                                                carts[index]
                                                                    .id!,
                                                                1);

                                                        if (selectCartController
                                                            .selectedCart
                                                            .contains(
                                                                carts[index]
                                                                    .id)) {
                                                          selectCartController
                                                              .addTotalPrice(
                                                                  carts[index]
                                                                      .product
                                                                      .price);
                                                        }
                                                      } catch (e) {
                                                        return;
                                                      }

                                                      // setState(() {
                                                      //   isAddButtonPressed =
                                                      //       false;
                                                      // });
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 18,
                                                      color: carts[index]
                                                                  .quantity <
                                                              carts[index]
                                                                  .product
                                                                  .stock
                                                          ? const Color(
                                                              0xFF6BCCC9)
                                                          : const Color(
                                                              0xFFB3B3B3),
                                                    ),
                                                  ),
                                                  Text(
                                                    carts[index]
                                                        .quantity
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      // print(carts[index].id!);
                                                      // setState(() {
                                                      //   isRemoveButtonPressed =
                                                      //       true;
                                                      // });
                                                      try {
                                                        await CartRepository
                                                            .instance
                                                            .subtractCartQuantity(
                                                                carts[index]
                                                                    .id!,
                                                                1);

                                                        if (selectCartController
                                                            .selectedCart
                                                            .contains(
                                                                carts[index]
                                                                    .id)) {
                                                          selectCartController
                                                              .removeTotalPrice(
                                                                  carts[index]
                                                                      .product
                                                                      .price);
                                                        }
                                                      } catch (e) {
                                                        return;
                                                      }
                                                      // setState(() {
                                                      //   isRemoveButtonPressed =
                                                      //       false;
                                                      // });
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                      color: carts[index]
                                                                  .quantity >
                                                              1
                                                          ? Colors.red
                                                          : const Color(
                                                              0xFFB3B3B3),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Obx(
            () => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: mediaQueryWidth * 0.9,
                height: mediaQueryHeight * 0.088,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFF91E0DD).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Checkbox(
                            value: selectCartController.isAllSelected.value,
                            onChanged: (value) {
                              final cartIds = getCartsController.carts
                                  .map((e) => e.id!)
                                  .toList();

                              // total price
                              total = getCartsController.carts
                                  .map((e) => e.product.price * e.quantity)
                                  .reduce((value, element) => value + element);

                              selectCartController.selectAll(cartIds, total);
                            },
                            activeColor: Colors.transparent,
                            checkColor: const Color(0xFF6BCCC9),
                            side: BorderSide.none,
                          ),
                        ),
                        SizedBox(width: mediaQueryWidth * 0.02),
                        const Text(
                          'Semua',
                          style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    ),
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
                    Container(
                      width: mediaQueryWidth * 0.251,
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
                              totalPrice: selectCartController.totalPrice.value,
                              cartIds:
                                  selectCartController.selectedCart.toList(),
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
