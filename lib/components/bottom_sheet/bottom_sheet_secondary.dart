import 'package:booking/source/typo.dart';
import 'package:flutter/material.dart';

class BottomSheetSecondary extends StatelessWidget {
  const BottomSheetSecondary({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 4,
          child: Text(
            text,
            style: tStyle.MediumBoldBlack(),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                size: 25,
              ),
            ),
          ),
        )
      ],
    );
  }
}
