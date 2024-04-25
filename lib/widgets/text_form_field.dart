// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  // final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final IconData prefixIcon;
  bool obscureText;
  final Function(String)? onSubmitted;
  final GestureDetector? suffixIcon;
  final TextInputType keyboardType;

  CustomTextField({
    super.key,
    // required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.onSubmitted,
    this.suffixIcon, 
    required this.keyboardType,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
            blurRadius: 6,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: TextField(
        // controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        cursorColor: const Color(0xFF6BCCC9),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF757B7B),
            fontSize: 16,
            fontWeight: FontWeight.normal,
            height: BorderSide.strokeAlignCenter,
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF6BCCC9),
            ),
            borderRadius: BorderRadius.circular(27),
          ),
          // ignore: unnecessary_null_comparison
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: const Color(0xFF757B7B))
              : null,
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    // Toggle obscureText
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  child: Icon(
                    widget.obscureText ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF757B7B),
                  ),
                )
              : null,
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
