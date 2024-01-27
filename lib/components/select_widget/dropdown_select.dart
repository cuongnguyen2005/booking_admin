// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class DropdownSelect extends StatelessWidget {
  const DropdownSelect({
    Key? key,
    required this.title,
    this.value,
    this.onChanged,
    this.items,
  }) : super(key: key);
  final String title;
  final Object? value;
  final void Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object>>? items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tStyle.MediumBoldBlack(),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(left: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1, color: AppColors.grey),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                style: tStyle.BaseRegularBlack(),
                hint: Text(title),
                value: value,
                onChanged: onChanged,
                items: items,
              ),
            ),
          )
        ],
      ),
    );
  }
}
