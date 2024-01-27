// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class TopBarSecondary extends StatelessWidget {
  const TopBarSecondary({
    Key? key,
    required this.startTime,
    required this.night,
    required this.room,
    required this.people,
    this.onTap,
  }) : super(key: key);
  final DateTime startTime;
  final int night;
  final String room;
  final int people;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.white,
                ),
                const SizedBox(width: 5),
                Text(DateFormat.yMd().format(startTime),
                    style: tStyle.BaseRegularWhite())
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.brightness_2,
                  color: AppColors.white,
                ),
                const SizedBox(width: 5),
                Text('$night đêm', style: tStyle.BaseRegularWhite())
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.bed_outlined,
                  color: AppColors.white,
                ),
                const SizedBox(width: 5),
                Text(room, style: tStyle.BaseRegularWhite())
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  color: AppColors.white,
                ),
                const SizedBox(width: 5),
                Text('$people', style: tStyle.BaseRegularWhite())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
