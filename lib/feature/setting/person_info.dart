import 'dart:convert';
import 'package:booking_admin/components/box/setting_box_secondary.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/text_field/text_field_default.dart';
import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/data/user_account.dart';
import 'package:booking_admin/feature/bottom_navi.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonInfo extends StatefulWidget {
  const PersonInfo({super.key});
  static String routeName = 'person_info';

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserAccount? usersAccount;
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

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        //pick image
        List<int> imageBytes = await pickedFile.readAsBytes();
        String base64Image = base64.encode(imageBytes);
        UserAccount userAcc = UserAccount(
          hoTen: usersAccount?.hoTen ?? '',
          gioiTinh: usersAccount?.gioiTinh ?? '',
          diaChi: usersAccount?.diaChi ?? '',
          avatar: base64Image,
          email: usersAccount?.email ?? '',
          sdt: usersAccount?.sdt ?? '',
          idCongty: usersAccount?.idCongty ?? '',
          quyenAdmin: usersAccount!.quyenAdmin,
          quyenUser: usersAccount!.quyenUser,
        );
        //save to firestore
        addtoServer(userAcc);
        //get user from firestore and update image on client
        UserAccount? userAccDt;
        FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get()
            .then((value) {
          setState(() {
            userAccDt = UserAccount.fromMap(value.data());
          });
          if (userAccDt?.avatar == base64Image) {
            setState(() {
              usersAccount?.avatar = userAccDt?.avatar ?? '';
            });
          } else {}
        });
      }
    } catch (e) {}
  }

  void addtoServer(UserAccount userAcc) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update(userAcc.toMap());
  }

  @override
  Widget build(BuildContext context) {
    final String avat = usersAccount?.avatar ?? '';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          TopBarDefault(
            text: 'Thông tin tài khoản',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: CircleAvatar(
                        radius: 75,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: avat.isEmpty
                              ? null
                              : MemoryImage(
                                  base64.decode(usersAccount?.avatar ?? '')),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: size.width * .465,
                      child: InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: const CircleAvatar(
                          backgroundColor: AppColors.green,
                          radius: 15,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SettingBoxSecondary(
                  icon1: Icons.email,
                  title: 'Địa chỉ email',
                  text: usersAccount?.email ?? '',
                  onTap: () {},
                ),
                SettingBoxSecondary(
                  icon1: Icons.person,
                  title: 'Tên',
                  text: usersAccount?.hoTen ?? '',
                  onTap: onTapChangeName,
                ),
                SettingBoxSecondary(
                  icon1: Icons.lock,
                  title: 'Mật khẩu',
                  text: 'Thay đổi mật khẩu',
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ButtonPrimary(
                    text: 'Đăng xuất',
                    onTap: logOut,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, BottomNavi.routeName, (route) => false);
  }

  void onTapChangeName() {
    final nameController = TextEditingController()
      ..text = usersAccount?.hoTen ?? '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: InputDefault(
            hintText: 'Họ tên',
            obscureText: false,
            controller: nameController,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: ButtonPrimary(
                text: 'Cập nhật',
                onTap: () {
                  UserAccount userAcc = UserAccount(
                    hoTen: nameController.text,
                    gioiTinh: usersAccount?.gioiTinh ?? '',
                    diaChi: usersAccount?.diaChi ?? '',
                    avatar: usersAccount?.avatar ?? '',
                    email: usersAccount?.email ?? '',
                    sdt: usersAccount?.sdt ?? '',
                    idCongty: usersAccount?.idCongty ?? '',
                    quyenAdmin: usersAccount!.quyenAdmin,
                    quyenUser: usersAccount!.quyenUser,
                  );
                  addtoServer(userAcc);
                  UserAccount? userAccDt;
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user?.uid)
                      .get()
                      .then((value) {
                    setState(() {
                      userAccDt = UserAccount.fromMap(value.data());
                    });
                    if (userAccDt?.hoTen == nameController.text) {
                      setState(() {
                        usersAccount?.hoTen = userAccDt?.hoTen ?? '';
                      });
                    } else {}
                  });
                  onTapBack();
                },
              ),
            )
          ],
        );
      },
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }
}
