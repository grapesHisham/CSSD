import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final bool? isReadOnly;
  final Size? textFieldSize;
  final BorderRadius borderRadius;
  final int? maxLendgth;
  final int? minLines;
  final int? maxLines;
  final EdgeInsets? scrollPadding;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

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
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.maxLendgth,
      this.onChanged,
      this.isReadOnly,
      this.focusNode,
      this.onFieldSubmitted,
      this.minLines,
      this.maxLines,
      this.scrollPadding});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: textFieldSize?.height ?? 48.0,
        maxWidth: textFieldSize?.width ?? double.infinity,
      ),
      child: TextFormField(
        scrollPadding:
            scrollPadding ?? const EdgeInsets.symmetric(vertical: 20.0),
        minLines: minLines,
        maxLines: maxLines,
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        readOnly: isReadOnly ?? false,
        onChanged: onChanged,
        maxLength: maxLendgth,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          counterText: '', //shows the count of maxlength , disbling it 4 now
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
          focusedBorder: textfieldBorder == true
              ? OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5))
              : InputBorder.none,
          errorBorder: textfieldBorder == true
              ? OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                )
              : InputBorder.none,
          focusedErrorBorder: textfieldBorder == true
              ? OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                )
              : InputBorder.none,
        ),
      ),
    );
  }
}
