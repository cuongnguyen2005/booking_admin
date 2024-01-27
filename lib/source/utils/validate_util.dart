// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidateUntils {
  final BuildContext ctx;
  ValidateUntils({
    required this.ctx,
  });
  //validate email
  static String? validateEmail(String? value) {
    // return null;
    if ((value ?? "").isEmpty) return "Trường này không được bỏ trống";
    RegExp emailRegexp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    // RegExp phoneRegexp = RegExp(r'^(03|05|07|08|09)+([0-9]{8})$');
    if (emailRegexp.hasMatch(value ?? "")) {
      return null;
    } else {
      return "Tài khoản sai định dạng";
    }
  }

  //validate phone number
  static String? validatePhonenumber(String? value) {
    // return null;
    if ((value ?? "").isEmpty) return "Trường này không được bỏ trống";
    // RegExp emailRegexp =
    //     RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    RegExp phoneRegexp = RegExp(r'^(03|05|07|08|09)+([0-9]{8})$');
    if (phoneRegexp.hasMatch(value ?? "")) {
      return null;
    } else {
      return "Số điện thoại sai định dạng";
    }
  }

  //Validate mật khẩu
  static String? validatePassword(String? value) {
    // return null;
    if ((value ?? "").isEmpty) return "Trường này không được bỏ trống";
    RegExp pwRegexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');
    if (pwRegexp.hasMatch(value ?? "")) {
      return null;
    } else {
      return "Mật khẩu phải bao gồm 1 chữ cái in hoa, 1 chữ cái in thường và 1 số";
    }
  }

  //Validate name
  static String? validateName(String? value) {
    // return null;
    if ((value ?? "").isEmpty) return "Trường này không được bỏ trống";
    return null;
  }
}
