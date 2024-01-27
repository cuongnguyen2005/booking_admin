import 'package:booking_admin/feature/user/bottom_navi.dart';
import 'package:booking_admin/routes.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.lightGrey.withOpacity(1),
        fontFamily: 'Roboto',
      ),
      initialRoute: BottomNavi.routeName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
