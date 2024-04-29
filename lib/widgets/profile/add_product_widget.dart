import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penstore/controller/product/add_product_controller.dart';
import 'package:penstore/models/category_model.dart';
import 'package:penstore/repository/category_repository.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  List<CategoryModel> categories = [];
  String? choosedCategory;
  bool isLoading = false;

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _stockFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  File? selectedImage;
  Uint8List? image;

  Future<void> _getCategories() async {
    setState(() {
      isLoading = true;
    });

    final CategoryRepository categoryRepository = CategoryRepository();
    final List<CategoryModel> _categories =
        await categoryRepository.getCategories();
    setState(() {
      categories = _categories;
      isLoading = false;
    });
  }

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
    _getCategories();
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      image = File(returnImage.path).readAsBytesSync();
      print('Image Path : ${selectedImage!.path}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final addProductController = Get.put(AddProductController());

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: isLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              right: -40,
                              top: -40,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const CircleAvatar(
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Form(
                                key: addProductController.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.list_alt_outlined),
                                          Text(
                                            "Tambah Produk",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _pickImageFromGallery();
                                        print('Pick Image');
                                      },
                                      child: DottedBorder(
                                        padding: EdgeInsets.all(20),
                                        child: const Column(
                                          children: [
                                            Text(
                                              "Gambar Produk",
                                              style: TextStyle(
                                                  // fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("Seret atau pilih gambar"),
                                            Icon(Icons.add_a_photo_outlined)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: addProductController
                                            .productNameController,
                                        focusNode: _nameFocusNode,
                                        keyboardType: TextInputType.name,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_nameFocusNode);
                                        },
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.inbox_outlined),
                                            hintText: 'Nama Produk'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Nama tidak boleh kosong";
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: DropdownButtonFormField(
                                        onChanged: (v) {
                                          setState(() {
                                            addProductController
                                                .choosedCategory = v;
                                          });
                                        },
                                        value: addProductController
                                            .choosedCategory,
                                        items: [
                                          ...categories.map((category) {
                                            return DropdownMenuItem<String>(
                                              value: category.id,
                                              child:
                                                  Text(category.category_name),
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
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: addProductController
                                            .priceController,
                                        keyboardType: TextInputType.number,
                                        focusNode: _priceFocusNode,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_priceFocusNode);
                                        },
                                        decoration: const InputDecoration(
                                            icon: Icon(
                                                Icons.attach_money_outlined),
                                            hintText: 'Harga Produk'),
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
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: addProductController
                                            .stockController,
                                        keyboardType: TextInputType.number,
                                        focusNode: _stockFocusNode,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_stockFocusNode);
                                        },
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.add_chart),
                                            hintText: 'Stok'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Stok tidak boleh kosong";
                                          } else if (int.parse(value) <= 0) {
                                            return "Stok tidak boleh kurang dari 0";
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller:
                                            addProductController.descController,
                                        focusNode: _descriptionFocusNode,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              _descriptionFocusNode);
                                        },
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.article_outlined),
                                            hintText: 'Deskripsi'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Deskripsi tidak boleh kosong";
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            addProductController
                                                .addProduct(context);
                                          },
                                          child: const Text('Tambah Produk')),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                )),
          );
        },
        child: const Text('Add Product'),
      ),
    );
  }
}
