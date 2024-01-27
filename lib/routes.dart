import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/feature/add_hotel.dart';
import 'package:booking_admin/feature/bottom_navi.dart';
import 'package:booking_admin/feature/detail_payment.dart';
import 'package:booking_admin/feature/login/bloc/login_bloc.dart';
import 'package:booking_admin/feature/login/login.dart';
import 'package:booking_admin/feature/setting/person_info.dart';
import 'package:booking_admin/feature/signup/bloc/signup_bloc.dart';
import 'package:booking_admin/feature/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
  // if (settings.name == SplashScreen.routeName) {
  //   return MaterialPageRoute(builder: (_) => const SplashScreen());
  // }
  if (settings.name == BottomNavi.routeName) {
    return MaterialPageRoute(builder: (_) => const BottomNavi());
  }
  if (settings.name == LoginPage.routeName) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => LoginBloc(),
              child: const LoginPage(),
            ));
  }
  if (settings.name == SignupPage.routeName) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => SignupBloc(),
              child: const SignupPage(),
            ));
  }
  if (settings.name == DetailPayment.routeName) {
    final arg = settings.arguments as DetailPaymentArg;
    return MaterialPageRoute(
        builder: (_) => DetailPayment(
              arg: arg,
            ));
  }
  if (settings.name == PersonInfo.routeName) {
    return MaterialPageRoute(builder: (_) => const PersonInfo());
  }

  if (settings.name == AddHotel.routeName) {
    final arg = settings.arguments as Hotels;
    return MaterialPageRoute(
        builder: (_) => AddHotel(
              hotel: arg,
            ));
  }

  return null;
};
