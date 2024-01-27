import 'package:booking/components/btn/button_primary.dart';
import 'package:booking/components/btn/button_secondary.dart';
import 'package:booking/components/top_bar/topbar_third.dart';
import 'package:booking/data/user_account.dart';
import 'package:booking/feature/user/bottom_navi.dart';
import 'package:booking/feature/user/login/login.dart';
import 'package:booking/feature/user/setting/person_info.dart';
import 'package:booking/source/colors.dart';
import 'package:booking/source/typo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingAdmin extends StatefulWidget {
  const SettingAdmin({super.key});

  @override
  State<SettingAdmin> createState() => _SettingAdminState();
}

class _SettingAdminState extends State<SettingAdmin> {
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
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.asset(
                                          'assets/images/avatar_white.jpg',
                                          height: 50,
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
                        onTap: onTapMoveUser,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text('Chuyển về trang người dùng'),
                        ),
                      )
                    ],
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
    Navigator.pushNamed(context, PersonInfo.routeName);
  }

  void onTapMoveUser() {
    Navigator.pushNamedAndRemoveUntil(
        context, BottomNavi.routeName, (route) => false);
  }
}
