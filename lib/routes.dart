import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/feature/admin/add_hotel.dart';
import 'package:booking_admin/feature/admin/bottom_admin.dart';
import 'package:booking_admin/feature/user/book/checkout.dart';
import 'package:booking_admin/feature/user/book/customer_info.dart';
import 'package:booking_admin/feature/user/book/payment_success.dart';
import 'package:booking_admin/feature/user/bottom_navi.dart';
import 'package:booking_admin/feature/user/detail_hotel/bloc/detail_hotel_bloc.dart';
import 'package:booking_admin/feature/user/detail_hotel/detail_hotel.dart';
import 'package:booking_admin/feature/user/detail_payment.dart';
import 'package:booking_admin/feature/user/login/bloc/login_bloc.dart';
import 'package:booking_admin/feature/user/login/login.dart';
import 'package:booking_admin/feature/user/search/bloc/search_bloc.dart';
import 'package:booking_admin/feature/user/search/search_page.dart';
import 'package:booking_admin/feature/user/setting/person_info.dart';
import 'package:booking_admin/feature/user/signup/bloc/signup_bloc.dart';
import 'package:booking_admin/feature/user/signup/signup.dart';
import 'package:booking_admin/feature/admin/signup_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/user/book/bloc/booking_bloc.dart';

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
  if (settings.name == DetailHotelPage.routeName) {
    final arg = settings.arguments as DetailHotelArg;
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => DetailHotelBloc(),
              child: DetailHotelPage(
                arg: arg,
              ),
            ));
  }
  if (settings.name == SearchPage.routeName) {
    final arg = settings.arguments as SearchPageArg;
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => SearchBloc(),
              child: SearchPage(
                arg: arg,
              ),
            ));
  }
  if (settings.name == CustomerInfo.routeName) {
    final arg = settings.arguments as CustomerInfoArg;
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) => BookingBloc(),
              child: CustomerInfo(
                arg: arg,
              ),
            ));
  }
  if (settings.name == Checkout.routeName) {
    final arg = settings.arguments as CheckoutArg;
    return MaterialPageRoute(
        builder: (_) => Checkout(
              arg: arg,
            ));
  }
  if (settings.name == PaymentSuccess.routeName) {
    final arg = settings.arguments as int;
    return MaterialPageRoute(
        builder: (_) => PaymentSuccess(
              totalMoney: arg,
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

  //admin
  if (settings.name == BottomNaviAdmin.routeName) {
    return MaterialPageRoute(builder: (_) => const BottomNaviAdmin());
  }
  if (settings.name == SignupAdminPage.routeName) {
    return MaterialPageRoute(builder: (_) => const SignupAdminPage());
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
