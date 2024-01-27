import 'package:booking/feature/admin/add_hotel.dart';
import 'package:booking/feature/admin/home_page_admin.dart';
import 'package:booking/feature/admin/setting_admin.dart';
import 'package:booking/source/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNaviAdmin extends StatefulWidget {
  const BottomNaviAdmin({super.key});
  static String routeName = 'bottom_navi_admin';

  @override
  State<BottomNaviAdmin> createState() => _BottomNaviAdminState();
}

class _BottomNaviAdminState extends State<BottomNaviAdmin> {
  @override
  void initState() {
    super.initState();
  }

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const HomePageAdmin(),
      const AddHotel(),
      const HomePageAdmin(),
      const SettingAdmin(),
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
                icon: Icons.notes,
                text: 'Thêm mới',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Thông báo',
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
