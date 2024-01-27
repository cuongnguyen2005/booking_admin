// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:booking_admin/source/colors.dart';
import 'package:flutter/material.dart';

const tStyle = TextStyle();

extension TextStyle$ on TextStyle {
  //headling
  TextStyle H1() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        fontStyle: FontStyle.normal,
      );
  TextStyle LargeBoldBlack() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontStyle: FontStyle.normal,
      );
  TextStyle LargeBoldWhite() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        fontStyle: FontStyle.normal,
      );
  TextStyle LargeRegular() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
        fontStyle: FontStyle.normal,
      );

  TextStyle MediumBoldWhite() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        fontStyle: FontStyle.normal,
      );
  TextStyle MediumBoldBlack() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontStyle: FontStyle.normal,
      );
  TextStyle MediumBoldGreen() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.green,
        fontStyle: FontStyle.normal,
      );
  TextStyle MediumRegularBlack() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
        fontStyle: FontStyle.normal,
      );
  TextStyle MediumRegularPrimary() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.primary,
        fontStyle: FontStyle.normal,
      );
  TextStyle MediumRegularWhite() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        fontStyle: FontStyle.normal,
      );
  TextStyle BaseBoldBlack() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontStyle: FontStyle.normal,
      );
  TextStyle BaseBoldPrimary() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        fontStyle: FontStyle.normal,
      );
  TextStyle BaseRegularBlack() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
        fontStyle: FontStyle.normal,
      );
  TextStyle BaseRegularYellow() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.yellow,
        fontStyle: FontStyle.normal,
      );
  TextStyle BaseRegularGreen() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.green,
        fontStyle: FontStyle.normal,
      );
  TextStyle BaseRegularWhite() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        fontStyle: FontStyle.normal,
      );
  TextStyle BaseRegularPrimary() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.primary,
        fontStyle: FontStyle.normal,
      );
  TextStyle BaseRegularGrey() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
        fontStyle: FontStyle.normal,
      );
  TextStyle SmallRegular() => copyWith(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
        fontStyle: FontStyle.normal,
      );
}
