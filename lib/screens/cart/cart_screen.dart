import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/widgets/home/banner_slider_widget.dart';

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
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        color: const Color(0xFF91E0DD).withOpacity(0.3),
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
                Container(
                  width: mediaQueryWidth * 0.60,
                  height: mediaQueryHeight * 0.055,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Keranjang Saya',
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: ' (2)',
                            style: TextStyle(
                              color: Color(0xFF6BCCC9),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      body: Stack(
        children: [
          SizedBox(
            height: mediaQueryHeight,
            width: mediaQueryWidth,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                      10,
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
                                  color:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
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
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Checkbox(
                                    value: _isCheckedList[index],
                                    onChanged: (value) {
                                      _onChanged(index, value!);
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
                                        ),
                                        child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image(
                                            filterQuality: FilterQuality.high,
                                            image: AssetImage(
                                              imgList[0],
                                            ),
                                            fit: BoxFit.cover,
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
                                    const Text(
                                      'Pensil Staedler 2B',
                                      style: TextStyle(
                                        color: Color(0xFF424242),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    const Text(
                                      'Rp 40.000 -',
                                      style: TextStyle(
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
                                            onTap: () => addQuantity(index),
                                            onTapDown: (_) {
                                              setState(() {
                                                isAddButtonPressed = true;
                                              });
                                            },
                                            onTapUp: (_) {
                                              setState(() {
                                                isAddButtonPressed = false;
                                              });
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
                                            quantityList[index].toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => removeQuantity(index),
                                            onTapDown: (_) {
                                              setState(() {
                                                isRemoveButtonPressed = true;
                                              });
                                            },
                                            onTapUp: (_) {
                                              setState(() {
                                                isRemoveButtonPressed = false;
                                              });
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
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Align(
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
                          value: isCheckedAll,
                          onChanged: _onCheckedAllChanged,
                          activeColor: Colors.transparent,
                          checkColor: const Color(0xFF6BCCC9),
                          side: BorderSide.none,
                        ),
                      ),
                      SizedBox(width: mediaQueryWidth * 0.02),
                      Text(
                        'Semua',
                        style: const TextStyle(
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
                      scrollDirection: Axis.horizontal ,
                      child: const Text(
                        'Rp 80.000.000,-',
                        style: TextStyle(
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
                      color: const Color(0xFF6BCCC9),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/checkout');
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
          )
        ],
      ),
    
    );
  }
}
