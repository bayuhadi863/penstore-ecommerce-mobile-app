import 'package:flutter/material.dart';
import 'package:penstore/widgets/decoration_input.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final FocusNode focusNode;
  final String hintText;
  final String prefixIcon;
  bool obscureText;
  final Function(String)? onSubmitted;
  final GestureDetector? suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  String? Function(dynamic value)? validator;

  CustomTextField({
    super.key,
    required this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.onSubmitted,
    this.suffixIcon,
    required this.keyboardType,
    required this.controller,
    required,
    this.validator,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late Color prefixIconColor;
  late Color suffixIconColor;

  @override
  void initState() {
    super.initState();
    // Initialize icon colors based on initial focus state
    prefixIconColor = widget.focusNode.hasFocus
        ? const Color(0xFF6BCCC9)
        : const Color(0xFF757B7B);
    suffixIconColor = const Color(0xFF757B7B);
    // Listen to changes in focus state
    // if (mounted) {
    //   widget.focusNode.addListener(updateIconColors);
    // }
  }

  @override
  void dispose() {
    // Dispose of the focus node listener
    widget.focusNode.removeListener(updateIconColors);
    // widget.focusNode.dispose();
    super.dispose();
  }

  // Method to update icon colors based on focus state
  void updateIconColors() {
    setState(() {
      prefixIconColor = widget.focusNode.hasFocus
          ? const Color(0xFF6BCCC9)
          : const Color(0xFF757B7B);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      cursorColor: const Color(0xFF6BCCC9),
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        focusColor: const Color(0xFF6BCCC9),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF757B7B),
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontFamily: 'Poppins',
        ),
        enabledBorder: DecoratedInputBorder(
          child: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(27),
            ),
            borderSide: BorderSide.none,
          ),
          shadow: BoxShadow(
            color: const Color(0xFF6BCCC9).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(1, 1),
          ),
        ),
        errorBorder: DecoratedInputBorder(
          child: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(27),
              ),
              borderSide: BorderSide(
                color: Color(0xFFF46B69),
              )),
          shadow: BoxShadow(
            color: const Color(0xFFF46B69).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(1, 1),
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontFamily: 'Poppins',
        ),
        focusedBorder: DecoratedInputBorder(
          child: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(27),
              ),
              borderSide: BorderSide(
                color: Color(0xFF6BCCC9),
              )),
          shadow: BoxShadow(
            color: const Color(0xFF6BCCC9).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(1, 1),
          ),
        ),
        prefixIcon: Container(
          height: 54,
          width: 54,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/icons/${widget.prefixIcon}.png',
            color: prefixIconColor,
            height: 24,
            width: 24,
            filterQuality: FilterQuality.high,
          ),
        ),
        suffixIcon: widget.suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          minHeight: 54,
          minWidth: 54,
        ),
      ),
      onFieldSubmitted: widget.onSubmitted,
      style: const TextStyle(
        color: Color(0xFF424242),
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins',
      ),
    );
  }
}
