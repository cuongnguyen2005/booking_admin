// ignore_for_file: public_member_api_docs, sort_constructors_first
//dùng trong trang chủ phần tìm kiếm
import 'package:booking/source/typo.dart';
import 'package:flutter/material.dart';
import 'package:booking/source/colors.dart';

class SearchBoxPrimary extends StatelessWidget {
  const SearchBoxPrimary({
    Key? key,
    required this.title,
    required this.content,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String content;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: AppColors.lightGrey))),
      child: Row(
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
    );
  }
}
