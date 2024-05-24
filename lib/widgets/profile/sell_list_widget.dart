import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/user_products_controller.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';
import 'package:penstore/widgets/no_product_sell.dart';
import 'package:skeletons/skeletons.dart';

class SellListProfile extends StatefulWidget {
  const SellListProfile({super.key});

  @override
  State<SellListProfile> createState() => _SellListProfileState();
}

class _SellListProfileState extends State<SellListProfile> {
  final UserProductsController userProductsController =
      Get.put(UserProductsController());

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: mediaQueryWidth,
      child: Obx(
        () {
          final loading = userProductsController.isLoading.value;
          // const loading = true;
          final products = userProductsController.userProducts;

          // order by created_at
          products.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

          return loading
              ? SkeletonItem(
                  child: Column(
                    children: List.generate(
                      3,
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
                  ? const NoProductSell()
                  : Column(
                      children: List.generate(
                        products.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                '/detail-product',
                                arguments: {'productId': products[index].id},
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 10),
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
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
                                            child: Image.network(
                                              products[index].imageUrl![0],
                                              height: 16,
                                              width: 16,
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
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
                                                products[index].name,
                                                style: const TextStyle(
                                                  color: Color(0xFF424242),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                width: 230,
                                                child: Text(
                                                  products[index].desc,
                                                  style: const TextStyle(
                                                    color: Color(0xFF757B7B),
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                Format.formatRupiah(
                                                    products[index].price),
                                                style: const TextStyle(
                                                  color: Color(0xFF91E0DD),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 26,
                                                    height: 26,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFF91E0DD)
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: Image.asset(
                                                        'assets/icons/edit_icon.png',
                                                        height: 16,
                                                        width: 16,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                      ),
                                                      style: ButtonStyle(
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(
                                                          const EdgeInsets.all(
                                                              0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  Container(
                                                    width: 26,
                                                    height: 26,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFFF46B69)
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: Image.asset(
                                                        'assets/icons/delete_icon.png',
                                                        height: 16,
                                                        width: 16,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                      ),
                                                      style: ButtonStyle(
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(
                                                          const EdgeInsets.all(
                                                              0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                          
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
