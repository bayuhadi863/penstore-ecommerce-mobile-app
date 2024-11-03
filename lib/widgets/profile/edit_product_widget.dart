import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penstore/controller/product/edit_product_controller.dart';
import 'package:penstore/controller/profile/user_products_controller.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/repository/category_repository.dart';
import 'package:penstore/widgets/decoration_input.dart';

class EditProductForm extends StatefulWidget {
  String productId;
  EditProductForm({required this.productId, super.key});

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  @override
  Widget build(BuildContext context) {
    // final mediaQueryHeigth = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return IconButton(
      icon: Image.asset(
        'assets/icons/edit_icon.png',
        height: 16,
        width: 16,
        filterQuality: FilterQuality.high,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(0),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                insetPadding: const EdgeInsets.all(20),
                titlePadding: const EdgeInsets.all(20),
                contentPadding: EdgeInsets.zero,
                surfaceTintColor: Colors.white,
                backgroundColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: SizedBox(
                  width: mediaQueryWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            color: Color(0xFF91E0DD),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ubah produk',
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
                                    color: const Color(0xFF91E0DD)
                                        .withOpacity(0.3),
                                    blurRadius: 16,
                                    offset: const Offset(1, 1),
                                  ),
                                ]),
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
                      ),
                    ],
                  ),
                ),
                content: ProductForm(
                  productId: widget.productId,
                ),
              )),
        );
      },
    );
  }
}

// DIDELE KENE BEN CONTEXT STATE E FUNGSI NAK ALERT DIALOG E
class ProductForm extends StatefulWidget {
  String productId;
  ProductForm({super.key, required this.productId});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  List<CategoryModel> categories = [];
  String? choosedCategory;
  bool isLoading = false;

  final editProductController = Get.put(EditProductController());
  final UserProductsController userProductsController =
      Get.put(UserProductsController());

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _stockFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  // variabel list gambar
  final List<File> selectedImages = [];
  final List<Uint8List> addedImages = [];

  Future<void> _getCategories() async {
    setState(() {
      isLoading = true;
    });

    final CategoryRepository categoryRepository = CategoryRepository();
    final List<CategoryModel> dataCategories =
        await categoryRepository.getCategories();
    setState(() {
      categories = dataCategories;
      isLoading = false;
    });
  }

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _stockFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    editProductController.getData(widget.productId);
    _getCategories();
  }

  // UPLOAD GAMBAR  ==============================
  Future<void> pickImagesFromGallery() async {
    List<XFile>? returnImages = await ImagePicker().pickMultiImage();
    if (returnImages.isEmpty) {
      print("gagal memilih gambar");
      return;
    }
    setState(() {
      for (final XFile image in returnImages) {
        selectedImages.add(File(image.path));
        addedImages.add(File(image.path).readAsBytesSync());
      }
      print("Tepilih gambar sebanyak ${selectedImages.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQueryHeigth = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return isLoading
        ? const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ),
          )
        : SizedBox(
            width: mediaQueryWidth,
            child: SingleChildScrollView(
              child: Form(
                key: editProductController.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // image box
                    GestureDetector(
                      onTap: () async {
                        pickImagesFromGallery();
                      },
                      child: SizedBox(
                        width: mediaQueryWidth * 0.8,
                        height: 127,
                        child: DottedBorder(
                          padding: const EdgeInsets.all(20),
                          color: const Color(0xFF6BCCC9),
                          strokeWidth: 1,
                          borderType: BorderType.RRect,
                          dashPattern: const [7, 7],
                          strokeCap: StrokeCap.butt,
                          radius: const Radius.circular(12),
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Gambar Produk",
                                  style: TextStyle(
                                    color: Color(0xFF424242),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const Text(
                                  'Seret atau pilih gambar',
                                  style: TextStyle(
                                    color: Color(0xFF757B7B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Image.asset(
                                  'assets/icons/Plus.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // list gambar dipilih yang baru

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        addedImages.length,
                        (index) => Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    addedImages[index],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImages.removeAt(index);
                                    addedImages.removeAt(index);
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // gambar lama
                    // list gambar dipilih yang baru
                    Text("Gambar Produk saat ini"),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        editProductController.previousImgUrls.length,
                        (index) => Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    editProductController
                                        .previousImgUrls[index],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editProductController.previousImgUrls
                                        .removeAt(index);
                                    // addedImages.removeAt(index);
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // // klik unutk uplod sekaligus
                    // ElevatedButton(
                    //   onPressed: () async {},
                    //   child: Text("Upload Gambar"),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: mediaQueryWidth * 0.8,
                      child: TextFormField(
                        controller: editProductController.productNameController,
                        focusNode: _nameFocusNode,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_nameFocusNode);
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
                          hintText: 'Nama Produk',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: mediaQueryWidth * 0.8,
                      child: DropdownButtonFormField(
                        hint: const Text(
                          "Tambah Kategori Baru",
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
                              color: const Color(0xFF6BCCC9).withOpacity(0.3),
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
                        onChanged: (v) {
                          setState(() {
                            editProductController.choosedCategory = v;
                          });
                        },
                        value: editProductController.choosedCategory,
                        items: [
                          ...categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category.id,
                              child: Text(category.category_name),
                            );
                          }).toList(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Kategori tidak boleh kosong";
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: mediaQueryWidth * 0.8,
                      child: TextFormField(
                        controller: editProductController.priceController,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        decoration: InputDecoration(
                          hintText: 'Harga Produk',
                          prefixIcon: Container(
                            height: 54,
                            width: 54,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/icons/price_outline.png',
                              color: const Color(0xFF6BCCC9),
                              height: 24,
                              width: 24,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Harga tidak boleh kosong";
                          } else if (int.parse(value) <= 0) {
                            return "Harga tidak boleh kurang dari 0";
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: mediaQueryWidth * 0.8,
                      child: TextFormField(
                        controller: editProductController.stockController,
                        keyboardType: TextInputType.number,
                        focusNode: _stockFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_stockFocusNode);
                        },
                        decoration: InputDecoration(
                          hintText: 'Stok',
                          prefixIcon: Container(
                            height: 54,
                            width: 54,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/icons/stock_outline.png',
                              color: const Color(0xFF6BCCC9),
                              height: 24,
                              width: 24,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Stok tidak boleh kosong";
                          } else if (int.parse(value) < 0) {
                            return "Stok tidak boleh kurang dari 0";
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: mediaQueryWidth * 0.8,
                      child: TextFormField(
                        controller: editProductController.descController,
                        focusNode: _descriptionFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        decoration: InputDecoration(
                          hintText: 'Deskripsi',
                          prefixIcon: Container(
                            height: 54,
                            width: 54,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/icons/description_outline.png',
                              color: const Color(0xFF6BCCC9),
                              height: 24,
                              width: 24,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Deskripsi tidak boleh kosong";
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6BCCC9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF6BCCC9),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6BCCC9).withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: 54,
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: SpinKitFadingCircle(
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              );
                            },
                            barrierDismissible: false,
                          );

                          await editProductController
                              .getImageUrls(selectedImages);
                          await editProductController.saveProduct(
                              widget.productId, context);

                          Navigator.of(context).pop();
                          // refresh products
                          userProductsController.getUserProducts();
                        },
                        child: const Center(
                          child: Text(
                            'Simpan Produk',
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
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
