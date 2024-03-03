import 'package:booking_admin/components/box/setting_box_primary.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/top_bar/topbar_third.dart';
import 'package:booking_admin/data/admin_account.dart';
import 'package:booking_admin/feature/login/login.dart';
import 'package:booking_admin/feature/setting/person_info.dart';
import 'package:booking_admin/feature/statis.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  User? user = FirebaseAuth.instance.currentUser;
  AdminAccount? adminAccount;

  void getInfo() {
    FirebaseFirestore.instance
        .collection('admins')
        .doc(user?.uid)
        .get()
        .then((value) {
      setState(() {
        adminAccount = AdminAccount.fromMap(value.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const TopBarThird(text: 'Cài đặt'),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: AppColors.primary,
                      ),
                      height: size.height * 0.18,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              (adminAccount?.avatar ?? '').isEmpty
                                  ? CircleAvatar(
                                      radius: 35,
                                      backgroundColor:
                                          AppColors.green.withOpacity(0.5),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: Image.network(
                                        adminAccount?.avatar ?? '',
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              const SizedBox(width: 16),
                              Text(adminAccount?.hoTen ?? '',
                                  style: tStyle.MediumBoldBlack()),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ButtonPrimary(
                            text: 'Xem thông tin tài khoản',
                            onTap: onTapShowInfoUser,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                SettingBoxPrimary(
                  icon1: Icons.circle,
                  title: 'Thống kê',
                  onTap: onTapStatis,
                ),
                SettingBoxPrimary(
                  icon1: Icons.wallet,
                  title: 'Thẻ của tôi',
                  onTap: () {},
                ),
                SettingBoxPrimary(
                  icon1: Icons.money,
                  title: 'Chủ đề',
                  onTap: () {},
                ),
                SettingBoxPrimary(
                  icon1: Icons.money,
                  title: 'Ngôn ngữ',
                  onTap: () {},
                ),
                SettingBoxPrimary(
                  icon1: Icons.question_answer,
                  title: 'Trung tâm hỗ trợ',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onTapLogin() {
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  void onTapShowInfoUser() {
    Navigator.pushNamed(context, PersonInfo.routeName, arguments: adminAccount)
        .then((value) => getInfo());
  }

  void onTapStatis() {
    Navigator.pushNamed(context, StatisPage.routeName);
  }
}
