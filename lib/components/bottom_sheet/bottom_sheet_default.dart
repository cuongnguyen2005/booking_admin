// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

import '../btn/button_primary.dart';

class BottomSheetDefault extends StatelessWidget {
  const BottomSheetDefault({
    Key? key,
    required this.title,
    required this.money,
    required this.textButton,
    this.onTap,
  }) : super(key: key);
  final String title;
  final int money;
  final String textButton;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      color: AppColors.white,
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: tStyle.BaseBoldBlack()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$money đ', style: tStyle.BaseBoldPrimary()),
                  const SizedBox(height: 8),
                  Text('Đã bao gồm thuế', style: tStyle.SmallRegular())
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          ButtonPrimary(
            text: textButton,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
