// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:booking/source/colors.dart';
import 'package:booking/source/typo.dart';

class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primary,
            border: Border.all(width: 1, color: AppColors.white)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            style: tStyle.MediumRegularWhite(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
