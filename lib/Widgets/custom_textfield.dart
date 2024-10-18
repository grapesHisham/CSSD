import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final VoidCallback? prefixIconOnTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? labelText;
  final Widget? label;
  final Widget? suffix;

  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.prefixIcon,
      this.controller,
      this.validator,
      this.keyboardType,
      this.obscureText = false,
      this.labelText,
      this.label,
      this.suffix,
      this.prefixIconOnTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffix,
        label: label,
        labelText: labelText,

        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? IconButton(
                onPressed: prefixIconOnTap,
                icon: Icon(
                  prefixIcon,
                  size: 12,
                ),
              )
            : null,
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        //   borderSide: const BorderSide(
        //     color: Colors.red,
        //   ),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        //   borderSide: const BorderSide(
        //     color: Colors.red,
        //   ),
        // ),
      ),
    );
  }
}