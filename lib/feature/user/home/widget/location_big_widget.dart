// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:booking/source/colors.dart';
import 'package:booking/source/typo.dart';

class HotelWidget extends StatelessWidget {
  const HotelWidget({
    Key? key,
    required this.image,
    required this.nameHotel,
    required this.addressHotel,
    required this.price,
    required this.star,
    this.onTap,
  }) : super(key: key);
  final Uint8List image;
  final String nameHotel;
  final String addressHotel;
  final String price;
  final String star;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: MediaQuery.of(context).size.width * 3 / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.memory(
                image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(nameHotel, style: tStyle.MediumBoldBlack()),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.yellow,
                          ),
                          const SizedBox(width: 8),
                          Text(star, style: tStyle.MediumBoldBlack()),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(addressHotel, style: tStyle.SmallRegular()),
                  const SizedBox(height: 8),
                  Text(price, style: tStyle.MediumBoldBlack()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
