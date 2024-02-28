// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking_admin/components/box/setting_box_secondary.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/text_field/text_field_default.dart';
import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/data/admin_account.dart';
import 'package:booking_admin/feature/bottom_navi.dart';
import 'package:booking_admin/source/colors.dart';

class PersonInfo extends StatefulWidget {
  const PersonInfo({
    Key? key,
    required this.adminAccount,
  }) : super(key: key);
  final AdminAccount adminAccount;
  static String routeName = 'person_info';

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  @override
  void initState() {
    super.initState();
  }

  User? user = FirebaseAuth.instance.currentUser;


  String imageUrl = '';

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      String fileName = user!.uid;
      if (pickedFile == null) {
        return;
      }
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirectImage = referenceRoot.child('admins');
      Reference referenceUpload = referenceDirectImage.child(fileName);
      try {
        await referenceUpload.putFile(File(pickedFile.path));
        imageUrl = await referenceUpload.getDownloadURL();
      } catch (e) {
        //some error
      }
      AdminAccount userAcc = AdminAccount(
          hoTen: widget.adminAccount.hoTen,
          gioiTinh: widget.adminAccount.gioiTinh,
          diaChi: widget.adminAccount.diaChi,
          avatar: imageUrl,
          email: widget.adminAccount.email,
          sdt: widget.adminAccount.sdt,
          maCty: widget.adminAccount.maCty);
      //save to firestore
      addtoServer(userAcc);
      //get user from firestore and update image on client
      AdminAccount? userAccFromDB;
      FirebaseFirestore.instance
          .collection('admins')
          .doc(user?.uid)
          .get()
          .then((value) {
        setState(() {
          userAccFromDB = AdminAccount.fromMap(value.data());
        });
        if (userAccFromDB?.avatar == imageUrl) {
          setState(() {
            widget.adminAccount.avatar = userAccFromDB?.avatar ?? '';
          });
        } else {}
      });
    } catch (e) {
      //some error
    }
  }

  void addtoServer(AdminAccount userAcc) async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(user!.uid)
        .update(userAcc.toMap());
  }

  @override
  Widget build(BuildContext context) {
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
                      child: (widget.adminAccount.avatar).isEmpty
                          ? CircleAvatar(
                              radius: 75,
                              backgroundColor: AppColors.green.withOpacity(0.5),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child: Image.network(
                                widget.adminAccount.avatar,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
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
                  text: widget.adminAccount.email,
                  onTap: () {},
                ),
                SettingBoxSecondary(
                  icon1: Icons.person,
                  title: 'Tên',
                  text: widget.adminAccount.hoTen,
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
      ..text = widget.adminAccount.hoTen;
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
                  AdminAccount userAcc = AdminAccount(
                    hoTen: nameController.text,
                    gioiTinh: widget.adminAccount.gioiTinh,
                    diaChi: widget.adminAccount.diaChi,
                    avatar: widget.adminAccount.avatar,
                    email: widget.adminAccount.email,
                    sdt:widget.adminAccount.sdt,
                    maCty: widget.adminAccount.maCty,
                  );
                  addtoServer(userAcc);
                  AdminAccount? userAccDt;
                  FirebaseFirestore.instance
                      .collection('admins')
                      .doc(user?.uid)
                      .get()
                      .then((value) {
                    setState(() {
                      userAccDt = AdminAccount.fromMap(value.data());
                    });
                    if (userAccDt?.hoTen == nameController.text) {
                      setState(() {
                        widget.adminAccount.hoTen = userAccDt?.hoTen ?? '';
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
