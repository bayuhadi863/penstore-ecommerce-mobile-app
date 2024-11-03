import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/auth/logout_controller.dart';
import 'package:penstore/controller/bill_payment/get_bill_payments_controller.dart';
import 'package:penstore/controller/category/delete_category_controller.dart';
import 'package:penstore/controller/category/get_categories_controller.dart';
import 'package:penstore/controller/profile/get_single_user_controller.dart';
import 'package:penstore/screens/admin/add_kategori.dart';
import 'package:penstore/screens/admin/edit_kategori.dart';
import 'package:penstore/utils/format.dart';
import 'package:penstore/widgets/confirm_action.dart';
import 'package:penstore/widgets/logout_confirm.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  final LogoutController logoutController = LogoutController();

  bool isClick = false;
  bool isClickLogout = false;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeigth = MediaQuery.of(context).size.height;

    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final GetCategoriesController getCategoriesController =
        Get.put(GetCategoriesController());

    final DeleteCategoryController deleteCategoryController =
        Get.put(DeleteCategoryController());

    final GetBillPaymentsController getBillPaymentsController =
        Get.put(GetBillPaymentsController());

    return Scaffold(
      // body: Center(
      //   child: Column(
      //     children: [
      //       ElevatedButton(
      //         onPressed: () async {
      //           await logoutController.logout(context);
      //         },
      //         child: const Text('Logout'),
      //       ),
      //     ],
      //   ),
      // ),
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFF91E0DD).withOpacity(0.3),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            color: const Color(0xFFFFFFFF),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.12,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        const AssetImage('assets/images/profile.jpeg'),
                    radius: MediaQuery.of(context).size.height * 0.08,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: const TextSpan(
                    text: "Admin Penstore",
                    style: TextStyle(
                      color: Color(0xFF757B7B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   isClickLogout = !isClickLogout;
                    // });
                    Get.dialog(const ConfirmLogoutWidget());
                  },
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity.comfortable,
                    maximumSize: const Size(110, 40),
                    side: isClickLogout
                        ? BorderSide.none
                        : const BorderSide(
                            color: Color(0xFFF46B69),
                            width: 1,
                          ),
                    backgroundColor: isClickLogout
                        ? const Color(0xFFF46B69)
                        : Colors.transparent,
                    foregroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Logout",
                          style: TextStyle(
                            color: isClickLogout
                                ? Colors.white
                                : const Color(0xFFF46B69),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: isClickLogout
                            ? Colors.white
                            : const Color(0xFFF46B69),
                      ),
                    ],
                  ),
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
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    unselectedLabelStyle: const TextStyle(
                      color: Color(0xFF757B7B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    dividerColor: const Color(0xFF91E0DD).withOpacity(0.1),
                    tabs: const [
                      Tab(text: 'Kategori'),
                      Tab(text: 'Tagihan'),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      // LIST PRODUK
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                                top: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        'Kategori Produk',
                                        style: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF6BCCC9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          color: Color(0xFFFFFFFF),
                                          size: 24,
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                            text: "Tambah",
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Get.dialog(const AddKategoriProduct());
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Obx(() {
                              final categories =
                                  getCategoriesController.categories;
                              final loading =
                                  getCategoriesController.isLoading.value;

                              return loading
                                  ? CircularProgressIndicator()
                                  : ListView.builder(
                                      itemCount: categories.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20, bottom: 20),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF91E0DD)
                                                    .withOpacity(0.3),
                                                blurRadius: 16,
                                                offset: const Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: RichText(
                                              text: TextSpan(
                                                  text: categories[index]
                                                      .category_name,
                                                  style: const TextStyle(
                                                    color: Color(0xFF424242),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  )),
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: 26,
                                                  height: 26,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF91E0DD)
                                                            .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Get.dialog(
                                                        EditKategoriProduct(
                                                          categoryId:
                                                              categories[index]
                                                                  .id!,
                                                        ),
                                                      );
                                                    },
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
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(
                                                        const EdgeInsets.all(0),
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
                                                    color:
                                                        const Color(0xFFF46B69)
                                                            .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      Get.dialog(
                                                        ConfirmAction(
                                                          title:
                                                              "Konfirmasi hapus",
                                                          messageTitle:
                                                              "Apakah anda yakin ingin menghapus kategori?",
                                                          message:
                                                              "Jika iya, kategori akan di hapus secara permanen!",
                                                          onPressed: () async {
                                                            await deleteCategoryController
                                                                .deleteCategory(
                                                                    categories[
                                                                            index]
                                                                        .id!,
                                                                    context);
                                                          },
                                                        ),
                                                      );
                                                    },
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
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(
                                                        const EdgeInsets.all(0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            }),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),

                      // LIST TAGIHAN
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                                top: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        'Konfirmasi tagihan',
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
                            Obx(() {
                              final billPayments =
                                  getBillPaymentsController.billPayments;

                              // sort by status
                              billPayments
                                  .sort((a, b) => a.status.compareTo(b.status));

                              final billLoading =
                                  getBillPaymentsController.isLoading.value;

                              return billLoading
                                  ? const CircularProgressIndicator()
                                  : Column(
                                      children: List.generate(
                                        billPayments.length,
                                        (index) {
                                          final billPayment =
                                              billPayments[index];

                                          final GetSingleUserController
                                              getSingleUserController = Get.put(
                                                  GetSingleUserController(
                                                      billPayment.userId),
                                                  tag: billPayment.userId
                                                      .toString());

                                          return InkWell(
                                            onTap: () {
                                              Get.toNamed('/payment-admin',
                                                  arguments: {
                                                    'billPaymentId':
                                                        billPayment.id,
                                                  });
                                            },
                                            child: Container(
                                              width: mediaQueryWidth * 0.9,
                                              margin: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10,
                                                  top: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF91E0DD)
                                                            .withOpacity(0.3),
                                                    blurRadius: 16,
                                                    offset: const Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(() {
                                                    final user =
                                                        getSingleUserController
                                                            .user.value;

                                                    return RichText(
                                                      text: TextSpan(
                                                        text: user.name,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF424242),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              'Jumlah transaksi: ${billPayment.total ~/ 1000}',
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF757B7B),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            const TextSpan(
                                                              text:
                                                                  'Total Tagihan: ',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF757B7B),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: Format
                                                                  .formatRupiah(
                                                                      billPayment
                                                                          .total),
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF6BCCC9),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Container(
                                                    height: 1,
                                                    width:
                                                        mediaQueryWidth * 0.9,
                                                    color:
                                                        const Color(0xFF757B7B),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: mediaQueryWidth *
                                                            0.3,
                                                        child: RichText(
                                                          text: const TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'Status tagihan',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF757B7B),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        // width: mediaQueryWidth * 0.5,
                                                        // height: 40,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Get.toNamed(
                                                                    '/payment-admin',
                                                                    arguments: {
                                                                  'billPaymentId':
                                                                      billPayment
                                                                          .id,
                                                                })!
                                                                .then((value) =>
                                                                    GetBillPaymentsController
                                                                        .instance
                                                                        .getAllBillPayments());
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              side: BorderSide(
                                                                color: billPayment
                                                                            .status ==
                                                                        'waiting'
                                                                    ? const Color(
                                                                        0xFF69A9F4)
                                                                    : billPayment.status ==
                                                                            'rejected'
                                                                        ? const Color(
                                                                            0xFFF46B69)
                                                                        : const Color(
                                                                            0xFF6BCCC9),
                                                                // color: order.status ==
                                                                //         'received'
                                                                //     ? const Color(0xFFF46B69)
                                                                //     : order.status ==
                                                                //             'on_process'
                                                                //         ? const Color(
                                                                //             0xFF69F477)
                                                                //         : order.status ==
                                                                //                 'rated'
                                                                //             ? const Color(
                                                                //                 0xFFF4CD69)
                                                                //             : order.status ==
                                                                //                     'waiting'
                                                                //                 ? const Color(
                                                                //                     0xFF6BCCC9)
                                                                //                 : const Color(
                                                                //                     0xFF69A9F4),
                                                              ),
                                                            ),
                                                          ),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: billPayment
                                                                              .status ==
                                                                          'waiting'
                                                                      ? "Konfirmasi Pembayaran"
                                                                      : billPayment.status ==
                                                                              'rejected'
                                                                          ? 'Ditolak'
                                                                          : 'Lunas',
                                                                  style:
                                                                      TextStyle(
                                                                    color: billPayment.status ==
                                                                            'waiting'
                                                                        ? const Color(
                                                                            0xFF69A9F4)
                                                                        : billPayment.status ==
                                                                                'rejected'
                                                                            ? const Color(0xFFF46B69)
                                                                            : const Color(0xFF6BCCC9),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                            }),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
