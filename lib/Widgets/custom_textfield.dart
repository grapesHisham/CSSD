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
  final Widget?
      label; // if you need other properties like to wrap with fitted box then use label instead of label text
  final Widget? suffix;
  final bool? textfieldBorder;
  final Size? textFieldSize;
  final BorderRadius borderRadius;

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
      this.prefixIconOnTap,
      this.textfieldBorder = true,
      this.textFieldSize,
      this.borderRadius = const BorderRadius.all(Radius.circular(10))});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: textFieldSize?.height ?? 48.0,
        maxWidth: textFieldSize?.width ?? double.infinity,
      ),
      child: TextFormField(
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
          border: textfieldBorder == false
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide:
                      const BorderSide(color: Colors.black, width: 1.0)),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: textfieldBorder == true
              ? OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: const BorderSide(
                    color: Colors.grey, // Border when the field is not focused
                    width: 1.0,
                  ),
                )
              : InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
