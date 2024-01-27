import 'dart:convert';

import 'package:booking_admin/components/box/setting_box_primary.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/btn/button_secondary.dart';
import 'package:booking_admin/components/dialog/dialog_primary.dart';
import 'package:booking_admin/components/top_bar/topbar_third.dart';
import 'package:booking_admin/data/user_account.dart';
import 'package:booking_admin/feature/admin/bottom_admin.dart';
import 'package:booking_admin/feature/user/login/login.dart';
import 'package:booking_admin/feature/user/setting/person_info.dart';
import 'package:booking_admin/feature/admin/signup_admin.dart';
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
    checkUserExist();
    getInfo();
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserAccount? usersAccount;
  void checkUserExist() {
    if (user != null) {
      setState(() {
        checkUser = true;
      });
    }
  }

  void getInfo() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((value) {
      setState(() {
        usersAccount = UserAccount.fromMap(value.data());
      });
    });
  }

  bool checkUser = false;
  @override
  Widget build(BuildContext context) {
    final String avat = usersAccount?.avatar ?? '';
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const TopBarThird(text: 'Cài đặt'),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if (checkUser == false)
                  Container(
                    color: AppColors.primary,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          'Đăng ký thành viên, hưởng nhiều ưu đãi',
                          style: tStyle.BaseRegularWhite(),
                        ),
                        const SizedBox(height: 16),
                        ButtonSecondary(
                          text: 'Đăng nhập, đăng ký',
                          onTap: onTapLogin,
                        )
                      ],
                    ),
                  ),
                if (checkUser == true)
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: AppColors.primary,
                              ),
                              height: size.height * 0.15,
                            ),
                            Container(
                              width: size.width,
                              height: size.height,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
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
                                      Container(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: avat.isEmpty
                                              ? null
                                              : MemoryImage(base64.decode(
                                                  usersAccount?.avatar ?? '')),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(usersAccount?.hoTen ?? '',
                                          style: tStyle.BaseBoldBlack()),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  ButtonPrimary(
                                    text: 'Xem thông tin tài khoản',
                                    onTap: onTapShowInfoUser,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: onTapMoveAdmin,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text('Chuyển sang quản trị viên'),
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 16),
                SettingBoxPrimary(
                  icon1: Icons.money,
                  title: 'Hoàn tiền',
                  onTap: () {},
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
    Navigator.pushNamed(context, PersonInfo.routeName).then((_) {
      // This block runs when you have returned back to the 1st Page from 2nd.
      setState(() {
        // Call setState to refresh the page.
      });
    });
  }

  void onTapMoveAdmin() {
    if (usersAccount?.quyenAdmin == 1) {
      Navigator.pushNamedAndRemoveUntil(
          context, BottomNaviAdmin.routeName, (route) => false);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return DialogPrimary(
            content: 'Bạn chưa có quyền admin. Đăng ký ngay!',
            buttonText: 'Đăng ký',
            onTap: onTapSignUpAdmin,
          );
        },
      );
    }
  }

  void onTapSignUpAdmin() {
    Navigator.pushNamed(context, SignupAdminPage.routeName);
  }
}
