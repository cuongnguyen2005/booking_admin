// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class TopBarDefault extends StatelessWidget {
  const TopBarDefault({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 0.2, color: AppColors.lightGrey)),
        color: AppColors.primary,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 50),
      child: Row(
        children: [
          InkWell(
              onTap: onTap,
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
                size: 20,
              )),
          const SizedBox(width: 8),
          Text(
            text,
            style: tStyle.LargeBoldWhite(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
