import 'package:flutter/material.dart';

class AddCollectionDialog extends StatelessWidget {
  const AddCollectionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
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
                  'Tersimpan di wishlist!',
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
        height: mediaQueryHeight * 0.25,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    'Kelompok kan barang dengan rapi, coba buatlah koleksi kategori baru! (Optional). ',
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
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF91E0DD),
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
                              width: 24,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          const Text(
                            'koleksi Baru',
                            style: TextStyle(
                              color: Color(0xFF757B7B),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
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
                      'Lihat WishList',
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
