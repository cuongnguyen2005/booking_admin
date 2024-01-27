// ignore_for_file: constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// const String LAGUAGE_CODE = 'languageCode';

// Future<Locale> setLocale(String languageCode) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString(LAGUAGE_CODE, languageCode);
//   return _locale(languageCode);
// }

// Future<Locale> getLocale() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String languageCode = prefs.getString(LAGUAGE_CODE) ?? 'en';
//   return _locale(languageCode);
// }

// Locale _locale(String languageCode) {
//   switch (languageCode) {
//     case 'en':
//       return const Locale('en');
//     case 'vi':
//       return const Locale('vi');
//     default:
//       return const Locale('en');
//   }
// }
