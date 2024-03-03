import 'package:booking_admin/data/admin_account.dart';
import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/feature/manage/add_room.dart';
import 'package:booking_admin/feature/bottom_navi.dart';
import 'package:booking_admin/feature/detail_payment.dart';
import 'package:booking_admin/feature/login/bloc/login_bloc.dart';
import 'package:booking_admin/feature/login/login.dart';
import 'package:booking_admin/feature/manage/add_hotel.dart';
import 'package:booking_admin/feature/manage/room/manage_room.dart';
import 'package:booking_admin/feature/seach_booking.dart';
import 'package:booking_admin/feature/setting/person_info.dart';
import 'package:booking_admin/feature/signup/bloc/signup_bloc.dart';
import 'package:booking_admin/feature/signup/signup.dart';
import 'package:booking_admin/feature/splash_page.dart';
import 'package:booking_admin/feature/statis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/manage/room/bloc/room_bloc.dart';

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
    final arg = settings.arguments as Booking;
    return MaterialPageRoute(
        builder: (_) => DetailPayment(
              booking: arg,
            ));
  }
  if (settings.name == PersonInfo.routeName) {
    final arg = settings.arguments as AdminAccount;
    return MaterialPageRoute(
        builder: (_) => PersonInfo(
              adminAccount: arg,
            ));
  }

  if (settings.name == AddRoom.routeName) {
    final arg = settings.arguments as AddRoomArg;
    return MaterialPageRoute(
        builder: (_) => AddRoom(
              arg: arg,
            ));
  }
  if (settings.name == AddHotel.routeName) {
    final arg = settings.arguments as Hotels?;
    return MaterialPageRoute(
        builder: (_) => AddHotel(
              hotel: arg,
            ));
  }
  if (settings.name == RoomManage.routeName) {
    final arg = settings.arguments as Hotels?;
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => RoomBloc(),
              child: RoomManage(
                hotel: arg,
              ),
            ));
  }
  if (settings.name == SearchBookingPage.routeName) {
    return MaterialPageRoute(builder: (_) => const SearchBookingPage());
  }
  if (settings.name == StatisPage.routeName) {
    return MaterialPageRoute(builder: (_) => const StatisPage());
  }
  if (settings.name == SplashScreen.routeName) {
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }

  return null;
};
