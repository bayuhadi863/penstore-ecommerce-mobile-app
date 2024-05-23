import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/controller/auth/logout_controller.dart';
import 'package:penstore/controller/profile/user_products_controller.dart';
import 'package:penstore/widgets/profile/add_product_widget.dart';
import 'package:penstore/widgets/profile/buy_list_widget.dart';
import 'package:penstore/widgets/profile/profile_image_widget.dart';
import 'package:penstore/widgets/profile/sale_list_widget.dart';
import 'package:penstore/widgets/profile/sell_list_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final userController = Get.put(UserController());
  final userProductController = Get.put(UserProductsController());
  //final _formKey = GlobalKey<FormState>();
  final FocusNode _searchFocusNode = FocusNode();
  late TabController tabController;

  bool isClick = false;
  bool isClickLogout = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeigth = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileImage(),
          SizedBox(
            height: mediaQueryHeigth * 0.08,
          ),
          Column(
            children: [
              Obx(
                () => Text(
                  userController.user.value.name,
                  style: const TextStyle(
                    color: Color(0xFF757B7B),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        maximumSize: Size(110, 40),
                        side: isClick
                            ? BorderSide.none
                            : BorderSide(
                                color: Color(0xFF6BCCC9),
                                width: 1,
                              ),
                        backgroundColor:
                            isClick ? Color(0xFF6BCCC9) : Colors.transparent,
                        foregroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Tagihan Anda",
                              style: TextStyle(
                                color:
                                    isClick ? Colors.white : Color(0xFF6BCCC9),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: isClick ? Colors.white : Color(0xFF6BCCC9),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        visualDensity: VisualDensity.comfortable,
                        maximumSize: Size(110, 40),
                        side: isClick
                            ? BorderSide.none
                            : BorderSide(
                                color: Color(0xFF64DF70),
                                width: 1,
                              ),
                        backgroundColor:
                            isClick ? Color(0xFF64DF70) : Colors.transparent,
                        foregroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Edit Profile",
                              style: TextStyle(
                                color:
                                    isClick ? Colors.white : Color(0xFF64DF70),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: isClick ? Colors.white : Color(0xFF64DF70),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isClickLogout = !isClickLogout;
                        });
                        final logoutController = Get.put(LogoutController());
                        logoutController.logout();
                      },
                      style: ElevatedButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        maximumSize: Size(110, 40),
                        side: isClickLogout
                            ? BorderSide.none
                            : BorderSide(
                                color: Color(0xFFF46B69),
                                width: 1,
                              ),
                        backgroundColor:
                            isClickLogout ? Color(0xFFF46B69) : Colors.transparent,
                        foregroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Logout",
                              style: TextStyle(
                                color:
                                    isClickLogout ? Colors.white : Color(0xFFF46B69),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: isClickLogout ? Colors.white : Color(0xFFF46B69),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "No Telepon",
                      style: const TextStyle(
                        color: Color(0xFF757B7B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      "no telepon",
                      style: const TextStyle(
                        color: Color(0xFF757B7B),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: Color(0xFF757B7B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      userController.user.value.email,
                      style: const TextStyle(
                        color: Color(0xFF757B7B),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBar(
              controller: tabController,
              indicatorWeight: 3.0,
              indicatorColor: const Color(0xFF91E0DD),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: const Color(0xFF91E0DD),
              unselectedLabelColor: Colors.grey,
              dividerHeight: 3.0,
              labelStyle: const TextStyle(
                color: Color(0xFF757B7B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              unselectedLabelStyle: const TextStyle(
                color: Color(0xFF757B7B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              dividerColor: const Color(0xFF91E0DD).withOpacity(0.1),
              tabs: const [
                Tab(text: 'Beli'),
                Tab(text: 'Jual'),
                Tab(text: 'Dibeli'),
              ],
            ),
          ),

          // TabBarView
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.58,
            child: TabBarView(
              controller: tabController,
              children: [
                // Buy List Widget
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/description_outline.png',
                                  height: 32,
                                  width: 32,
                                  filterQuality: FilterQuality.high,
                                  color: const Color(0xFF91E0DD),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Pesanan Saya',
                                  style: TextStyle(
                                    color: Color(0xFF424242),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      BuyListProfile(),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
                // Sell List Widget
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/description_outline.png',
                                  height: 32,
                                  width: 32,
                                  filterQuality: FilterQuality.high,
                                  color: const Color(0xFF91E0DD),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Produk Saya',
                                  style: TextStyle(
                                    color: Color(0xFF424242),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: AddProductForm(),
                            )
                          ],
                        ),
                      ),
                      SellListProfile(),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),

                // Dibeli List Widget
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/description_outline.png',
                                  height: 32,
                                  width: 32,
                                  filterQuality: FilterQuality.high,
                                  color: const Color(0xFF91E0DD),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Penjualan',
                                  style: TextStyle(
                                    color: Color(0xFF424242),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SaleListProfile(),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const AddProductForm(),
        ],
      ),
    );
  }
}
