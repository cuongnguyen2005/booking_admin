// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/data/admin_account.dart';
import 'package:booking_admin/source/utils/validate_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/select_widget/dropdown_select.dart';
import 'package:booking_admin/components/text_field/box_input.dart';
import 'package:booking_admin/components/text_field/text_field_default.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/data/location.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:booking_admin/source/colors.dart';

class AddHotel extends StatefulWidget {
  const AddHotel({
    Key? key,
    this.hotel,
  }) : super(key: key);
  final Hotels? hotel;
  static String routeName = 'manage_hotel';

  @override
  State<AddHotel> createState() => _AddHotelState();
}

class _AddHotelState extends State<AddHotel> {
  @override
  void initState() {
    super.initState();
    getInfoUser();
    imageKS = widget.hotel?.anhKS ?? '';
    nameHotelController.text = widget.hotel?.tenKS ?? '';
    addHotelController.text = widget.hotel?.diaChi ?? '';
    city = widget.hotel?.thanhPho ?? location[0].name;
    descriptionController.text = widget.hotel?.moTa ?? '';
    priceController.text = (widget.hotel?.giaKS ?? '').toString();
  }

  User? user = FirebaseAuth.instance.currentUser;
  AdminAccount? adminAccount;
  void getInfoUser() async {
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

  //chọn ảnh\
  String imageUrl = '';
  Future<void> pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    String fileName = '${user!.uid} ${DateTime.now().toString()}';
    if (pickedFile == null) {
      return;
    }
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectImage = referenceRoot.child('hotels');
    Reference referenceUpload = referenceDirectImage.child(fileName);
    try {
      await referenceUpload.putFile(File(pickedFile.path));
      imageUrl = await referenceUpload.getDownloadURL();
      setState(() {
        imageKS = imageUrl;
      });
    } catch (e) {
      //some error
    }
  }

  String city = '';
  String imageKS = '';
  final TextEditingController nameHotelController = TextEditingController();
  final TextEditingController addHotelController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarDefault(
            text: 'Quản lý khách sạn',
            onTap: onTapBack,
          ),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 8),
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Stack(children: [
                          imageKS == ''
                              ? Container(
                                  height: 250,
                                  color: AppColors.grey.withOpacity(0.5),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 250,
                                  child: Image.network(
                                    imageKS,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          InkWell(
                            onTap: pickImage,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 30,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        ]),
                        const SizedBox(height: 24),
                        BoxInput(
                          title: 'Tên khách sạn',
                          inputDefault: InputDefault(
                            hintText: 'Tên khách sạn',
                            obscureText: false,
                            controller: nameHotelController,
                            validator: ValidateUntils.validateName,
                            autovalidateMode: AutovalidateMode.disabled,
                          ),
                        ),
                        BoxInput(
                          title: 'Địa chỉ',
                          inputDefault: InputDefault(
                            hintText: 'Địa chỉ',
                            obscureText: false,
                            controller: addHotelController,
                            validator: ValidateUntils.validateName,
                            autovalidateMode: AutovalidateMode.disabled,
                          ),
                        ),
                        DropdownSelect(
                          title: 'Thành phố',
                          value: city,
                          onChanged: (value) {
                            setState(() {
                              city = value.toString();
                            });
                          },
                          items: location.map((e) {
                            return DropdownMenuItem(
                              value: e.name,
                              child: Text(e.name),
                            );
                          }).toList(),
                        ),
                        BoxInput(
                          title: 'Giá phòng',
                          inputDefault: InputDefault(
                            keyboardType: TextInputType.number,
                            hintText: 'Giá phòng',
                            obscureText: false,
                            controller: priceController,
                            validator: ValidateUntils.validateName,
                            autovalidateMode: AutovalidateMode.disabled,
                          ),
                        ),
                        BoxInput(
                          title: 'Mô tả',
                          inputDefault: InputDefault(
                            hintText: 'Mô tả',
                            obscureText: false,
                            controller: descriptionController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.all(16),
                  child: ButtonPrimary(
                    text: 'Cập nhật',
                    onTap:
                        widget.hotel == null ? onTapAddHotel : onTapEditHotel,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapAddHotel() async {
    if (formKey.currentState!.validate()) {
      if (user != null) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              title:
                  Icon(Icons.check_circle, size: 50, color: AppColors.primary),
              content: Text('Thành công', textAlign: TextAlign.center),
            );
          },
        );
        await BookingRepo.addHotels(
          nameHotelController.text,
          addHotelController.text,
          city,
          int.parse(priceController.text),
          imageKS,
          adminAccount?.maKS ?? '',
          descriptionController.text,
        );
        onTapBack();
      }
    }
  }

  void onTapEditHotel() async {
    if (formKey.currentState!.validate()) {
      if (user != null) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              title:
                  Icon(Icons.check_circle, size: 50, color: AppColors.primary),
              content: Text('Thành công', textAlign: TextAlign.center),
            );
          },
        );
        await BookingRepo.editHotels(
          widget.hotel!.idKS,
          nameHotelController.text,
          addHotelController.text,
          city,
          int.parse(priceController.text),
          imageKS,
          widget.hotel!.maKS,
          descriptionController.text,
        );
        onTapBack();
      }
    }
  }
}
