import 'package:booking_admin/feature/calendar/bloc/calendar_bloc.dart';
import 'package:booking_admin/feature/calendar/calendar.dart';
import 'package:booking_admin/feature/home/bloc/home_bloc.dart';
import 'package:booking_admin/feature/home/home.dart';
import 'package:booking_admin/feature/setting/settings.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({
    Key? key,
    this.isUpdate,
  }) : super(key: key);
  final bool? isUpdate;
  static String routeName = "/bottom";

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  @override
  void initState() {
    super.initState();
  }

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomePage(),
      ),
      BlocProvider(
        create: (context) => CalendarBloc(),
        child: const CalendarWidget(),
      ),
      const HomePage(),
      const Settings(),
    ];
    return Scaffold(
      body: tabs[_pageIndex],
      bottomNavigationBar: Container(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: 24,
          ),
          child: GNav(
            selectedIndex: _pageIndex,
            padding: const EdgeInsets.all(8),
            tabBorderRadius: 20,
            backgroundColor: AppColors.white,
            activeColor: AppColors.primary,
            tabBackgroundColor: AppColors.lightPrimary.withOpacity(0.5),
            color: AppColors.grey,
            gap: 4,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Trang chủ',
              ),
              GButton(
                icon: Icons.calendar_month,
                text: 'Lịch trình',
              ),
              GButton(
                icon: Icons.circle,
                text: 'Thống kê',
              ),
              GButton(
                icon: Icons.person,
                text: 'Cài đặt',
              ),
            ],
            onTabChange: (value) {
              setState(() {
                _pageIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
