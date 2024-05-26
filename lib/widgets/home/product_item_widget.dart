import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/cart/add_cart_controller.dart';
import 'package:penstore/controller/product/products_controller.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/controller/wishlist/add_product_wishlist_controller.dart';
import 'package:penstore/models/product_model.dart';
import 'package:penstore/widgets/home/add_collection_dialog_widget.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductModel product;

  const ProductItemWidget({
    super.key,
    required this.product,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  final ProductController productController = Get.put(ProductController());
  final UserController userController = Get.put(UserController());
  final AddCartController addCartController = Get.put(AddCartController());
  final AddProductWishlistController addWishlistController =
      Get.put(AddProductWishlistController());
  bool _isWishlist = false;

  @override
  void initState() {
    super.initState();
    checkWishlist();
  }

  Future<void> checkWishlist() async {
    bool isWishlist =
        await addWishlistController.checkWishlist(widget.product.id);

    // fix bug
    if (mounted) {
      setState(() {
        _isWishlist = isWishlist;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Get.toNamed('/detail-product',
                  arguments: {'productId': widget.product.id});
            },
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(10),
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
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(12),
                          child: (widget.product.imageUrl != null &&
                                  widget.product.imageUrl!.isNotEmpty)
                              ? Image.network(
                                  widget.product.imageUrl![0],
                                  height: 16,
                                  width: 16,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/icons/cart_outline.png',
                                  height: 16,
                                  width: 16,
                                  filterQuality: FilterQuality.high,
                                ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {
                            if (_isWishlist) {
                              // jika sudah langsung hapus
                              await addWishlistController
                                  .removeFromWishlist(widget.product.id);
                              setState(() {
                                checkWishlist();
                              });
                            } else {
                              // jika belum maka pop up tambahkan ke wishlist
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AddCollectionDialog(
                                    productId: widget.product.id,
                                  );
                                },
                              );
                              setState(() {
                                checkWishlist();
                              });
                            }
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
                              _isWishlist
                                  ? 'assets/icons/favorite_fill.png'
                                  : 'assets/icons/favorite_outline.png',
                              height: 13,
                              width: 13,
                              filterQuality: FilterQuality.high,
                              color: const Color(0xFF6BCCC9),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
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
                                widget.product.desc,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Rp ${widget.product.price} -',
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
          widget.product.userId == userController.user.value.id
              ? Container()
              : Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      addCartController.createCart(userController.user.value,
                          widget.product, 1, context);
                    },
                    child: Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF91E0DD).withOpacity(0.3),
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
  }
}
