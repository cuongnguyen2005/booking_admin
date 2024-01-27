// ignore_for_file: public_member_api_docs, sort_constructors_first
//dùng trong trang thông tin thanh toán, và thanh toán thành công
import 'package:booking/source/colors.dart';
import 'package:flutter/material.dart';

import 'package:booking/source/typo.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1, color: AppColors.lightGrey),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: tStyle.BaseRegularBlack()),
          Text(content, style: tStyle.BaseBoldBlack())
        ],
      ),
    );
  }
}
