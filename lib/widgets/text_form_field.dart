import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final FocusNode focusNode;
  final String hintText;
  final String prefixIcon;
  bool obscureText;
  final Function(String)? onSubmitted;
  final GestureDetector? suffixIcon;
  final TextInputType keyboardType;

  CustomTextField({
    super.key,
    required this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.onSubmitted,
    this.suffixIcon,
    required this.keyboardType,
  });

  @override
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
    widget.focusNode.addListener(updateIconColors);
  }

  @override
  void dispose() {
    // Dispose of the focus node listener
    widget.focusNode.removeListener(updateIconColors);
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
    return Container(
      height: 54,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF91E0DD).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: TextField(
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        cursorColor: const Color(0xFF6BCCC9),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          focusColor: const Color(0xFF6BCCC9),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF757B7B),
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF6BCCC9),
            ),
            borderRadius: BorderRadius.circular(27),
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
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    // Toggle obscureText
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                      suffixIconColor = widget.obscureText
                          ? const Color(0xFF757B7B)
                          : const Color(0xFF6BCCC9);
                    });
                  },
                  child: Container(
                    height: 54,
                    width: 54,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/icons/visibility.png',
                      color: suffixIconColor,
                      height: 24,
                      width: 24,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 54,
            minWidth: 54,
          ),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
