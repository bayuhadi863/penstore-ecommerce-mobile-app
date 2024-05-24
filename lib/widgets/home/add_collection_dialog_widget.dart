import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/product/products_controller.dart';
import 'package:penstore/controller/wishlist/add_product_wishlist_controller.dart';
import 'package:penstore/models/wishlist_model.dart';
import 'package:penstore/repository/wishlist_repository.dart';
import 'package:penstore/widgets/decoration_input.dart';

class AddCollectionDialog extends StatefulWidget {
  const AddCollectionDialog({
    Key? key,
    required this.productId,
  }) : super(key: key);
  final String productId;

  @override
  _AddCollectionDialogState createState() => _AddCollectionDialogState();
}

class _AddCollectionDialogState extends State<AddCollectionDialog> {
  final addProductWishlistController = Get.put(AddProductWishlistController());
  final ProductController productController = Get.put(ProductController());
  bool isLoading = false;

  final FocusNode _nameFocusNode = FocusNode();
  List<WishlistModel> _wishlists = [];

  Future<void> getUserWishlists() async {
    setState(() {
      isLoading = true;
    });

    final WishlistRepository wishlistRepository = WishlistRepository();
    final List<WishlistModel> wishlists = await wishlistRepository
        .getUserWishlist(addProductWishlistController.user!.uid);
    setState(() {
      _wishlists = wishlists;
      print(_wishlists);
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserWishlists();

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    // final mediaQueryHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.all(20),
      surfaceTintColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/wishlist_outline.png',
                  height: 32,
                  width: 32,
                  filterQuality: FilterQuality.high,
                  color: const Color(0xFF91E0DD),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Simpan ke wishlist!',
                  style: TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF91E0DD).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/icons/close_fill.png',
                    height: 24,
                    width: 24,
                    color: const Color(
                      0xFF91E0DD,
                    ),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      content: isLoading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              ),
            )
          : Form(
              child: SizedBox(
                width: mediaQueryWidth,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Kelompokkan barang dengan rapi, coba buatlah koleksi kategori baru! (Optional). ',
                            style: TextStyle(
                              color: Color(0xFF757B7B),
                              fontSize: 11,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                addProductWishlistController.isAddNewWishlist =
                                    !addProductWishlistController
                                        .isAddNewWishlist;
                                addProductWishlistController
                                    .wishlistNameController.text = '';
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 54,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: addProductWishlistController
                                          .isAddNewWishlist
                                      ? const Color.fromARGB(255, 220, 44, 28)
                                      : const Color(0xFF91E0DD),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 54,
                                    height: 54,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      'assets/icons/add_outline.png',
                                      height: 24,
                                      color: addProductWishlistController
                                              .isAddNewWishlist
                                          ? const Color.fromARGB(
                                              255, 220, 44, 28)
                                          : const Color(0xFF91E0DD),
                                      width: 24,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  Text(
                                    addProductWishlistController
                                            .isAddNewWishlist
                                        ? 'Batalkan'
                                        : 'Koleksi Baru',
                                    style: TextStyle(
                                      color: addProductWishlistController
                                              .isAddNewWishlist
                                          ? Colors.red[600]
                                          : const Color(0xFF757B7B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (addProductWishlistController
                              .isAddNewWishlist) ...[
                            // Jika membuat wishlist baru
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: addProductWishlistController
                                    .wishlistNameController,
                                focusNode: _nameFocusNode,
                                keyboardType: TextInputType.name,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_nameFocusNode);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    height: 54,
                                    width: 54,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/icons/product_outline.png',
                                      color: const Color(0xFF6BCCC9),
                                      height: 24,
                                      width: 24,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  hintText: 'Nama Wishlist Baru',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Nama tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                          // dropdown wishlist
                          if (!addProductWishlistController.isAddNewWishlist &&
                              addProductWishlistController
                                      .wishlistNameController.text ==
                                  '') ...[
                            SizedBox(
                              width: mediaQueryWidth * 0.8,
                              child: DropdownButtonFormField<String>(
                                hint: const Text(
                                  "Pilih Wishlist",
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                ),
                                decoration: InputDecoration(
                                  errorBorder: DecoratedInputBorder(
                                    child: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    shadow: BoxShadow(
                                      color: const Color(0xFF6BCCC9)
                                          .withOpacity(0.3),
                                      blurRadius: 16,
                                      offset: const Offset(1, 1),
                                    ),
                                  ),
                                  prefixIcon: Container(
                                    height: 54,
                                    width: 54,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/icons/category_outline.png',
                                      color: const Color(0xFF6BCCC9),
                                      height: 24,
                                      width: 24,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    addProductWishlistController
                                        .choosedWishlist = value!;
                                    addProductWishlistController
                                        .isAddNewWishlist = false;

                                    addProductWishlistController
                                        .wishlistNameController.text = '';
                                  });
                                },
                                value: addProductWishlistController
                                    .choosedWishlist,
                                items: _wishlists.map((wishlist) {
                                  return DropdownMenuItem<String>(
                                    value: wishlist.id,
                                    child: Text(wishlist.name),
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Nama Wishlist tidak boleh kosong";
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ]
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (addProductWishlistController.isAddNewWishlist) {
                            // jika menambahkan wishlist baru
                            String newWishlistId =
                                await addProductWishlistController
                                    .createWishlist();
                            await addProductWishlistController.addToWishlist(
                                widget.productId, newWishlistId, context);
                          } else {
                            // jika memilih wishlist
                            await addProductWishlistController.addToWishlist(
                                widget.productId,
                                addProductWishlistController.choosedWishlist!,
                                context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF91E0DD),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF91E0DD),
                              width: 1,
                            ),
                          ),
                          width: double.infinity,
                          height: 54,
                          child: const Center(
                            child: Text(
                              'Simpan Wishlist',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
