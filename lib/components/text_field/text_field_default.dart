import 'package:booking/source/colors.dart';
import 'package:booking/source/typo.dart';
import 'package:flutter/material.dart';

class InputDefault extends StatelessWidget {
  const InputDefault({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.autovalidateMode,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      controller: controller,
      style: tStyle.MediumRegularBlack(),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: AppColors.white,
        filled: true,
        hintText: hintText,
        hintStyle: tStyle.BaseRegularGrey(),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: AppColors.lightGrey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 16,
        ),
      ),
    );
  }
}
