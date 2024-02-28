// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class TopBarSecond extends StatelessWidget {
  const TopBarSecond({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String text;
  final void Function()? onTap;

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
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              text,
              style: tStyle.LargeBoldWhite(),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            right: 10,
            child: InkWell(
              onTap: onTap,
              child: const Icon(
                Icons.search,
                color: AppColors.white,
                size: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
