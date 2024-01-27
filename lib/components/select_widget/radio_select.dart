// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:booking/source/colors.dart';
import 'package:booking/source/typo.dart';

class RadioSelect extends StatefulWidget {
  const RadioSelect({
    Key? key,
    this.groupValue,
    this.onChanged1,
    this.onChanged2,
    required this.title,
    required this.value1,
    required this.value2,
  }) : super(key: key);
  final Object? groupValue;
  final void Function(Object?)? onChanged1;
  final void Function(Object?)? onChanged2;
  final String title;
  final String value1;
  final String value2;

  @override
  State<RadioSelect> createState() => _RadioSelectState();
}

class _RadioSelectState extends State<RadioSelect> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.door_sliding, color: AppColors.grey),
            const SizedBox(width: 10),
            Text(
              widget.title,
              style: tStyle.BaseBoldBlack(),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: RadioListTile(
                value: 'đôi',
                groupValue: widget.groupValue,
                title: Text(widget.value1),
                onChanged: widget.onChanged1,
              ),
            ),
            Expanded(
              flex: 1,
              child: RadioListTile(
                value: 'đơn',
                groupValue: widget.groupValue,
                title: Text(widget.value2),
                onChanged: widget.onChanged2,
              ),
            )
          ],
        ),
      ],
    );
  }
}
