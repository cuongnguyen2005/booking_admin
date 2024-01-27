// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking_admin/components/text_field/text_field_default.dart';
import 'package:booking_admin/source/typo.dart';

class BoxInput extends StatelessWidget {
  const BoxInput({
    Key? key,
    required this.title,
    required this.inputDefault,
  }) : super(key: key);
  final String title;
  final InputDefault inputDefault;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: tStyle.MediumBoldBlack(),
        ),
        const SizedBox(height: 8),
        inputDefault,
        const SizedBox(height: 16),
      ],
    );
  }
}
