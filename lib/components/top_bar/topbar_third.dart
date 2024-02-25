// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class TopBarThird extends StatelessWidget {
  const TopBarThird({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 0.2, color: AppColors.lightGrey)),
        color: AppColors.primary,
      ),
      padding: EdgeInsets.only(
          left: 16, right: 16, bottom: 16, top: size.height * 0.08),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          style: tStyle.LargeBoldWhite(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
