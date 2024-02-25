// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:flutter/material.dart';

class TopBarNoBackground extends StatelessWidget {
  const TopBarNoBackground({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: EdgeInsets.only(
          left: 16, right: 16, bottom: 16, top: size.height * 0.08),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.grey.withOpacity(0.5)),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.white,
                  size: 20,
                ),
              )),
          const SizedBox(width: 8),
          Text(
            text,
            style: tStyle.LargeBoldWhite(),
          ),
        ],
      ),
    );
  }
}
