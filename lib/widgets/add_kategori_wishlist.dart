import 'package:flutter/material.dart';

class AddKategoriWishlistWidget extends StatelessWidget {
  const AddKategoriWishlistWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      titlePadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      contentPadding: const EdgeInsets.only(top: 5, bottom: 20, left: 20, right: 20),
      surfaceTintColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: SizedBox(
        // color: const Color(0xFF91E0DD),
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
                  'Buat Koleksi Baru',
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
            )
          ],
        ),
      ),
      content: SizedBox(
        width: mediaQueryWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: mediaQueryWidth * 0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {},
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
                        hintText: 'Nama Kategori',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama tidak boleh kosong";
                        }
                        return null;
                      },
                      cursorColor: const Color(0xFF6BCCC9),
                      style: const TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text:
                          'Buat kategori koleksi baru, hanya kamu yang bisa melihat koleksi ini',
                      style: TextStyle(
                        color: Color(0xFF757B7B),
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF91E0DD),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF91E0DD).withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 54,
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text(
                      'Tambah Produk',
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
    );
  }
}
