// ignore_for_file: public_member_api_docs, sort_constructors_first
//dùng trong trang chủ phần tìm kiếm
import 'package:booking_admin/source/typo.dart';
import 'package:flutter/material.dart';
import 'package:booking_admin/source/colors.dart';

class SearchBoxSecondary extends StatelessWidget {
  const SearchBoxSecondary({
    Key? key,
    required this.title,
    required this.content,
    required this.icon,
    this.onTap,
    required this.night,
  }) : super(key: key);
  final String title;
  final String content;
  final IconData icon;
  final void Function()? onTap;
  final int night;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: AppColors.lightGrey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.grey,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: tStyle.BaseRegularBlack()),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: onTap,
                    child: Text(content, style: tStyle.BaseBoldBlack()),
                  ),
                ],
              )
            ],
          ),
          Text('$night đêm', style: tStyle.BaseBoldBlack()),
        ],
      ),
    );
  }
}
