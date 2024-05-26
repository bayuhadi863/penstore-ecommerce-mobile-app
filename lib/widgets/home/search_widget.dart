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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: CustomTextField(
        focusNode: _searchFocusNode,
        hintText: "Cari barang apa?",
        prefixIcon: 'search',
        keyboardType: TextInputType.text,
        controller: TextEditingController(),
      ),
    );
  }
}
