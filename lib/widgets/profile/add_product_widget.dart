import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  var _value = "-1";
  File? selectedImage;
  Uint8List? image;

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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  content: Stack(
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
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.inbox_outlined),
                                      hintText: 'Nama Produk'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: DropdownButtonFormField(
                                  onChanged: (v) {},
                                  value: _value,
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text("Pilih Kategori"),
                                      value: "-1",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Alat Tulis"),
                                      value: "1",
                                    ),
                                    DropdownMenuItem(
                                        child: Text("Lainnya"), value: "2"),
                                  ],
                                ),
                                // TextFormField(
                                //   decoration: const InputDecoration(
                                //       icon: Icon(Icons.list),
                                //       hintText: 'Kategori Produk'),
                                // ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.attach_money_outlined),
                                      hintText: 'Harga Produk'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.add_chart),
                                      hintText: 'Stok'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.article_outlined),
                                      hintText: 'Deskripsi'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                      }
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
