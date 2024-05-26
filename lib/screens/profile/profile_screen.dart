import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/payment_method/delete_payment_method_controller.dart';
import 'package:penstore/controller/payment_method/get_user_payment_method_controller.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/controller/profile/user_products_controller.dart';
import 'package:penstore/widgets/confirm_action.dart';
import 'package:penstore/widgets/logout_confirm.dart';
import 'package:penstore/widgets/no_data.dart';
import 'package:penstore/widgets/profile/add_method_payment_widget.dart';
import 'package:penstore/widgets/profile/add_product_widget.dart';
import 'package:penstore/widgets/profile/buy_list_widget.dart';
import 'package:penstore/widgets/profile/edit_method_payment.dart';
import 'package:penstore/widgets/profile/edit_profile.dart';
import 'package:penstore/widgets/profile/form_tagihan.dart';
import 'package:penstore/widgets/profile/profile_image_widget.dart';
import 'package:penstore/widgets/profile/sale_list_widget.dart';
import 'package:penstore/widgets/profile/sell_list_widget.dart';
import 'package:skeletons/skeletons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final userController = Get.put(UserController());
  final userProductController = Get.put(UserProductsController());

  final GetUserPaymentMethodController getUserPaymentMethodController = Get.put(
      GetUserPaymentMethodController(FirebaseAuth.instance.currentUser!.uid));

  final DeletePaymentMethodController deletePaymentMethodController =
      Get.put(DeletePaymentMethodController());
  //final _formKey = GlobalKey<FormState>();
  final FocusNode _searchFocusNode = FocusNode();
  late TabController tabController;

  bool isClick = false;
  bool isClickLogout = false;

  bool isAllList = false;

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
          ProfileImage(
            imageUrl: userController.user.value.imageUrl,
          ),
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
                        Get.dialog(const FormTagihanWidget());
                      },
                      style: ElevatedButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        maximumSize: const Size(110, 40),
                        side: isClick
                            ? BorderSide.none
                            : const BorderSide(
                                color: Color(0xFF6BCCC9),
                                width: 1,
                              ),
                        backgroundColor: isClick
                            ? const Color(0xFF6BCCC9)
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
                              text: "Tagihan Anda",
                              style: TextStyle(
                                color: isClick
                                    ? Colors.white
                                    : const Color(0xFF6BCCC9),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: isClick
                                ? Colors.white
                                : const Color(0xFF6BCCC9),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(const EditProfile());
                        },
                        style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          visualDensity: VisualDensity.comfortable,
                          maximumSize: const Size(110, 40),
                          side: isClick
                              ? BorderSide.none
                              : const BorderSide(
                                  color: Color(0xFF64DF70),
                                  width: 1,
                                ),
                          backgroundColor: isClick
                              ? const Color(0xFF64DF70)
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
                                text: "Edit Profile",
                                style: TextStyle(
                                  color: isClick
                                      ? Colors.white
                                      : const Color(0xFF64DF70),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: isClick
                                  ? Colors.white
                                  : const Color(0xFF64DF70),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
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
                      "No Telepon",
                      style: TextStyle(
                        color: Color(0xFF757B7B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      userController.user.value.phone ?? "Belum diatur",
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
                      const BuyListProfile(),
                      const SizedBox(
                        height: 165,
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
                                  color: const Color(0xFFF4CD69),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: const TextSpan(
                                    text: 'Metode Pembayaran',
                                    style: TextStyle(
                                      color: Color(0xFF424242),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: AddPaymentMethodWidget(),
                            )
                          ],
                        ),
                      ),
                      Obx(() {
                        final paymentMethods =
                            getUserPaymentMethodController.paymentMethods;

                        // sort by name
                        // paymentMethods.sort((a, b) {
                        //   return a.name.compareTo(b.name);
                        // });

                        final loading =
                            getUserPaymentMethodController.isLoading.value;

                        return loading
                            ? SkeletonItem(
                                child: Column(
                                  children: List.generate(
                                    3,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 10,
                                          top: 10),
                                      child: SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                          width: double.infinity,
                                          height: 100,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : paymentMethods.isEmpty
                                ? const NoData(
                                    title: "Maaf, ",
                                    subTitle: "Belum ada metode pembayaran",
                                    suggestion:
                                        "Silahkan Tambahkan metode pembayaran untuk menjual produk!",
                                  )
                                : Column(
                                    children: [
                                      Column(
                                        children: List.generate(
                                            isAllList == true
                                                ? paymentMethods.length
                                                : paymentMethods.length > 1
                                                    ? 1
                                                    : paymentMethods.length,
                                            (index) {
                                          // paymentMethods.sort((a, b) {
                                          //   return a.name.compareTo(b.name);
                                          // });
                                          final paymentMethod =
                                              paymentMethods[index];

                                          return paymentMethod.name ==
                                                  "COD (Bayar di tempat)"
                                              ? Container(
                                                  width: double.infinity,
                                                  margin: const EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      bottom: 10,
                                                      top: 10),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                                  0xFF91E0DD)
                                                              .withOpacity(0.3),
                                                          blurRadius: 16,
                                                          offset: const Offset(
                                                              1, 1),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            RichText(
                                                              text:
                                                                  const TextSpan(
                                                                text:
                                                                    "COD (Bayar di tempat)",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF605B57),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 26,
                                                              height: 26,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                        0xFFF46B69)
                                                                    .withOpacity(
                                                                        0.3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                              child: IconButton(
                                                                onPressed: () async {
                                                                  Get.dialog(
                                                                    ConfirmAction(
                                                                      title:
                                                                          "Konfirmasi hapus",
                                                                      messageTitle:
                                                                          "Apakah anda yakin ingin menghapus metode pembayaran?",
                                                                      message:
                                                                          "Jika iya, metode pembayaran akan di hapus secara permanen!",
                                                                      onPressed:
                                                                          () async {
                                                                        await deletePaymentMethodController.deletePaymentMethod(
                                                                            paymentMethod.id!,
                                                                            context);

                                                                        getUserPaymentMethodController.getPaymentMethodByUserId(FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid);
                                                                        // ignore: use_build_context_synchronously
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  );
                                                                },
                                                                icon:
                                                                    Image.asset(
                                                                  'assets/icons/delete_icon.png',
                                                                  height: 16,
                                                                  width: 16,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                ),
                                                                style:
                                                                    ButtonStyle(
                                                                  shape:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                    ),
                                                                  ),
                                                                  padding:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: double.infinity,
                                                  height: 100,
                                                  margin: const EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      bottom: 10,
                                                      top: 10),
                                                  child: Container(
                                                    height: 100,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                                  0xFF91E0DD)
                                                              .withOpacity(0.3),
                                                          blurRadius: 16,
                                                          offset: const Offset(
                                                              1, 1),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    paymentMethod
                                                                        .name,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF605B57),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                text: paymentMethod
                                                                    .recipientName
                                                                    .toUpperCase(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF605B57),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    paymentMethod
                                                                        .number,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF6BCCC9),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 26,
                                                                  height: 26,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                            0xFF91E0DD)
                                                                        .withOpacity(
                                                                            0.3),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                          Get.dialog(
                                                                            const EditPaymentMethod(),
                                                                          );
                                                                        },
                                                                    icon: Image
                                                                        .asset(
                                                                      'assets/icons/edit_icon.png',
                                                                      height:
                                                                          16,
                                                                      width: 16,
                                                                      filterQuality:
                                                                          FilterQuality
                                                                              .high,
                                                                    ),
                                                                    style:
                                                                        ButtonStyle(
                                                                      shape: MaterialStateProperty
                                                                          .all(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(6),
                                                                        ),
                                                                      ),
                                                                      padding:
                                                                          MaterialStateProperty
                                                                              .all(
                                                                        const EdgeInsets
                                                                            .all(
                                                                            0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 8.0),
                                                                Container(
                                                                  width: 26,
                                                                  height: 26,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                            0xFFF46B69)
                                                                        .withOpacity(
                                                                            0.3),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      Get.dialog(
                                                                        ConfirmAction(
                                                                          title:
                                                                              "Konfirmasi hapus",
                                                                          messageTitle:
                                                                              "Apakah anda yakin ingin menghapus methode pembayaran",
                                                                          message:
                                                                            "Jika iya, metode pembayaran akan di hapus secara permanen!",
                                                                          onPressed:
                                                                              () async {
                                                                            await deletePaymentMethodController.deletePaymentMethod(paymentMethod.id!,
                                                                                context);

                                                                            getUserPaymentMethodController.getPaymentMethodByUserId(FirebaseAuth.instance.currentUser!.uid);
                                                                            // ignore: use_build_context_synchronously
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                      );
                                                                    },
                                                                    icon: Image
                                                                        .asset(
                                                                      'assets/icons/delete_icon.png',
                                                                      height:
                                                                          16,
                                                                      width: 16,
                                                                      filterQuality:
                                                                          FilterQuality
                                                                              .high,
                                                                    ),
                                                                    style:
                                                                        ButtonStyle(
                                                                      shape: MaterialStateProperty
                                                                          .all(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(6),
                                                                        ),
                                                                      ),
                                                                      padding:
                                                                          MaterialStateProperty
                                                                              .all(
                                                                        const EdgeInsets
                                                                            .all(
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
                                                );
                                        }),
                                      ),
                                      paymentMethods.length <= 1
                                          ? Container()
                                          : isAllList == false
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isAllList = true;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: const Text(
                                                        'Lebih Banyak',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF6BCCC9),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isAllList = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: const Text(
                                                        'Lebih Sedikit',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF6BCCC9),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                    ],
                                  );
                      }),
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
                      const SellListProfile(),
                      SizedBox(
                        height: mediaQueryHeigth * 0.21,
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
                      const SaleListProfile(),
                      const SizedBox(
                        height: 165,
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
