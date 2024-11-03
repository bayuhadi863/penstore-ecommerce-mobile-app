import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/admin_payment_method/get_single_admin_payment_method_controller.dart';
import 'package:penstore/controller/bill_payment/confirm_bill_payment_controller.dart';
import 'package:penstore/controller/bill_payment/get_single_bill_payment_controller.dart';
import 'package:penstore/controller/bill_payment/reject_bill_payment_controller.dart';
import 'package:penstore/controller/profile/get_single_user_controller.dart';
import 'package:penstore/screens/admin/appbar_payment_admin.dart';
import 'package:penstore/utils/format.dart';

class PaymentAdmin extends StatefulWidget {
  const PaymentAdmin({super.key});

  @override
  State<PaymentAdmin> createState() => _PaymentAdminState();
}

class _PaymentAdminState extends State<PaymentAdmin> {
  final bool isLunas = false;
  final bool isGagal = false;

  String billPaymentId = '';

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments = Get.arguments;
    final billPaymentId = arguments['billPaymentId'];

    setState(() {
      this.billPaymentId = billPaymentId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final GetSingleBillPaymentController getSingleBillPaymentController =
        Get.put(GetSingleBillPaymentController(billPaymentId: billPaymentId));

    final ConfirmBillPaymentController confirmPaymentController =
        Get.put(ConfirmBillPaymentController());

    final RejectBillPaymentController refusePaymentController =
        Get.put(RejectBillPaymentController());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const AppBarAdminPayment(),
      ),
      body: Obx(() {
        final billPayment = getSingleBillPaymentController.billPayment.value;
        final loading = getSingleBillPaymentController.isLoading.value;

        if (loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final GetSingleUserController getSingleUserController =
            Get.put(GetSingleUserController(billPayment.userId));

        final GetSingleAdminPaymentMethodController
            getSingleAdminPaymentMethodController = Get.put(
                GetSingleAdminPaymentMethodController(
                    adminPaymentMethodId: billPayment.adminPaymentMethodId));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: mediaQueryWidth * 0.9,
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(billPaymentId),
                  Obx(() {
                    final user = getSingleUserController.user.value;
                    return RichText(
                      text: TextSpan(
                        text: user.name,
                        style: const TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text:
                              'Jumlah transaksi: ${billPayment.total ~/ 1000}',
                          style: const TextStyle(
                            color: Color(0xFF757B7B),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Total Tagihan: ',
                              style: TextStyle(
                                color: Color(0xFF757B7B),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextSpan(
                              text: Format.formatRupiah(billPayment.total),
                              style: const TextStyle(
                                color: Color(0xFF6BCCC9),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
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
                    width: mediaQueryWidth * 0.9,
                    color: const Color(0xFF757B7B),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
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
                    child: Obx(() {
                      final adminPaymentMethod =
                          getSingleAdminPaymentMethodController
                              .adminPaymentMethod.value;
                      final adminPaymentMethodloading =
                          getSingleAdminPaymentMethodController.isLoading.value;
                      return adminPaymentMethodloading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/icons/money_outline.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Metode Pembayaran',
                                      style: TextStyle(
                                        color: Color(0xFF424242),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF757B7B),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: adminPaymentMethod.name,
                                          style: const TextStyle(
                                            color: Color(0xFF757B7B),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Nama Rekening',
                                      style: TextStyle(
                                        color: Color(0xFF757B7B),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      adminPaymentMethod.recipientName,
                                      style: const TextStyle(
                                        color: Color(0xFF757B7B),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'No Rek',
                                      style: TextStyle(
                                        color: Color(0xFF757B7B),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      adminPaymentMethod.number,
                                      style: const TextStyle(
                                        color: Color(0xFF757B7B),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // LIHAT BUKTI
                                if (billPayment.status == 'waiting') ...[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF6BCCC9),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF91E0DD)
                                                .withOpacity(0.6),
                                            blurRadius: 16,
                                            offset: const Offset(1, 1),
                                          )
                                        ]),
                                    width: double.infinity,
                                    height: 54,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.dialog(
                                          AlertDialog(
                                            insetPadding: const EdgeInsets.only(
                                                top: 30,
                                                bottom: 30,
                                                right: 20,
                                                left: 20),
                                            alignment: Alignment.topCenter,
                                            titlePadding: const EdgeInsets.only(
                                                top: 20, right: 20, left: 20),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20),
                                            surfaceTintColor: Colors.white,
                                            backgroundColor:
                                                const Color(0xFFFFFFFF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            title: SizedBox(
                                              // color: const Color(0xFF91E0DD),
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/wishlist_outline.png',
                                                        height: 32,
                                                        width: 32,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                        color: const Color(
                                                            0xFF6BCCC9),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const Text(
                                                        'Bukti Pembayaran',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF424242),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: 32,
                                                        width: 32,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: const Color(
                                                                        0xFF6BCCC9)
                                                                    .withOpacity(
                                                                        0.3),
                                                                blurRadius: 16,
                                                                offset:
                                                                    const Offset(
                                                                        1, 1),
                                                              ),
                                                            ]),
                                                        child: Image.asset(
                                                          'assets/icons/close_fill.png',
                                                          height: 24,
                                                          width: 24,
                                                          color: const Color(
                                                              0xFF6BCCC9),
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            content: SizedBox(
                                              width: mediaQueryWidth,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                      0xFF6BCCC9)
                                                                  .withOpacity(
                                                                      0.3),
                                                              blurRadius: 16,
                                                              offset:
                                                                  const Offset(
                                                                      1, 1),
                                                            ),
                                                          ],
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child:
                                                              SingleChildScrollView(
                                                            physics:
                                                                const BouncingScrollPhysics(
                                                              decelerationRate:
                                                                  ScrollDecelerationRate
                                                                      .fast,
                                                            ),
                                                            child: billPayment
                                                                        .imageUrl ==
                                                                    ''
                                                                ? Image.asset(
                                                                    "assets/images/banner1.jpg",
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  )
                                                                : Image.network(
                                                                    billPayment
                                                                        .imageUrl,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: const Color(
                                                                    0xFFF46B69),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: const Color(
                                                                            0xFFF46B69)
                                                                        .withOpacity(
                                                                            0.6),
                                                                    blurRadius:
                                                                        16,
                                                                    offset:
                                                                        const Offset(
                                                                            1,
                                                                            1),
                                                                  )
                                                                ]),
                                                            width:
                                                                mediaQueryWidth *
                                                                    0.38,
                                                            height: 54,
                                                            child: TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                await refusePaymentController
                                                                    .rejectBillPayment(
                                                                  billPaymentId,
                                                                  context,
                                                                );
                                                              },
                                                              child: Center(
                                                                child: RichText(
                                                                  text: const TextSpan(
                                                                      text: 'Gagal',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                      )),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: const Color(
                                                                    0xFF6BCCC9),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: const Color(
                                                                            0xFF91E0DD)
                                                                        .withOpacity(
                                                                            0.6),
                                                                    blurRadius:
                                                                        16,
                                                                    offset:
                                                                        const Offset(
                                                                            1,
                                                                            1),
                                                                  )
                                                                ]),
                                                            width:
                                                                mediaQueryWidth *
                                                                    0.38,
                                                            height: 54,
                                                            child: TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                await confirmPaymentController
                                                                    .confirmBillPayment(
                                                                  billPaymentId,
                                                                  context,
                                                                  billPayment
                                                                      .total,
                                                                  billPayment
                                                                      .userId,
                                                                );
                                                              },
                                                              child: Center(
                                                                child: RichText(
                                                                  text: const TextSpan(
                                                                      text: 'Lunas',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                      )),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Center(
                                        child: RichText(
                                          text: const TextSpan(
                                              text: 'Lihat Bukti',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 14,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                if (billPayment.status == 'confirmed') ...[
                                  Container(
                                    width: double.infinity,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF69F477)
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF69F477)
                                              .withOpacity(0.2),
                                          blurRadius: 16,
                                          offset: const Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            color: Color(0xFF69F477),
                                          ),
                                          SizedBox(
                                              width: mediaQueryWidth * 0.04),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Pembayaran',
                                                  style: TextStyle(
                                                    color: Color(0xFF757B7B),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' LUNAS',
                                                  style: TextStyle(
                                                    color: Color(0xFF69F477),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                                if (billPayment.status == 'rejected') ...[
                                  Container(
                                    width: double.infinity,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF46B69)
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFF46B69)
                                              .withOpacity(0.2),
                                          blurRadius: 16,
                                          offset: const Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            color: Color(0xFFF46B69),
                                          ),
                                          SizedBox(
                                              width: mediaQueryWidth * 0.04),
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Pembayaran',
                                                  style: TextStyle(
                                                    color: Color(0xFF757B7B),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' DITOLAK',
                                                  style: TextStyle(
                                                    color: Color(0xFFF46B69),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ],
                            );
                    }),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
