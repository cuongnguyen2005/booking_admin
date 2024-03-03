import 'package:booking_admin/feature/login/login.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    onBoard();
    super.initState();
  }

  onBoard() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset('assets/images/icon.jpeg'),
      ),
    );
  }
}
