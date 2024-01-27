// ignore_for_file: public_member_api_docs, sort_constructors_first
//Sử dụng trong thông tin tài khoản
import 'package:flutter/material.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class SettingBoxSecondary extends StatelessWidget {
  const SettingBoxSecondary({
    Key? key,
    required this.icon1,
    required this.title,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final IconData icon1;
  final String title;
  final String text;
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
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: tStyle.BaseBoldBlack(),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      text,
                      style: tStyle.BaseRegularBlack(),
                    ),
                  ],
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
