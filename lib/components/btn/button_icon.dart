// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking/source/colors.dart';

class ButtonIconWidget extends StatelessWidget {
  const ButtonIconWidget({
    Key? key,
    this.onTap,
    required this.icon,
  }) : super(key: key);
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.lightGrey),
            color: AppColors.white),
        child: Icon(
          icon,
          size: 22,
        ),
      ),
    );
  }
}
