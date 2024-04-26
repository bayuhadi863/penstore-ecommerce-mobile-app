import 'package:flutter/material.dart';
import 'package:penstore/widgets/text_form_field.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final FocusNode _searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: mediaQueryWidth * 0.730,
            child: CustomTextField(
              focusNode: _searchFocusNode,
              hintText: "Cari barang apa?",
              prefixIcon: 'search',
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF6BCCC9),
              borderRadius: BorderRadius.circular(50),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF91E0DD).withOpacity(0.8),
                  blurRadius: 16,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/option.png',
                height: 24,
                width: 24,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
