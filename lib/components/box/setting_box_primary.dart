// ignore_for_file: public_member_api_docs, sort_constructors_first
// Sử dụng trong cài đặt
import 'package:booking_admin/source/typo.dart';
import 'package:flutter/material.dart';
import 'package:booking_admin/source/colors.dart';

class SettingBoxPrimary extends StatelessWidget {
  const SettingBoxPrimary({
    Key? key,
    required this.icon1,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final IconData icon1;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10, bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon1),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: tStyle.BaseBoldBlack(),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
