// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class ButtonOutline extends StatelessWidget {
  const ButtonOutline({
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
            border: Border.all(width: 1, color: AppColors.primary)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            style: tStyle.MediumRegularPrimary(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
