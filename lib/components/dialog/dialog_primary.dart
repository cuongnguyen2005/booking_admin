// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking/components/btn/button_outline.dart';
import 'package:flutter/material.dart';
import 'package:booking/components/btn/button_primary.dart';

class DialogPrimary extends StatelessWidget {
  const DialogPrimary({
    Key? key,
    this.onTap,
    required this.content,
    required this.buttonText,
  }) : super(key: key);
  final void Function()? onTap;
  final String content;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ButtonOutline(
                  text: 'Đóng',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ButtonPrimary(
                  text: buttonText,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
