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
    city = widget.hotel?.thanhPho ?? '';
    locationCode = widget.hotel?.maDiaDiem ?? '';
    descriptionController.text = widget.hotel?.moTa ?? '';
    priceController.text = (widget.hotel?.giaKS ?? 0).toString();
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

  static String convert(String str) {
    str = str.replaceAll("à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ", "a");
    str = str.replaceAll("è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ", "e");
    str = str.replaceAll("ì|í|ị|ỉ|ĩ", "i");
    str = str.replaceAll("ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ", "o");
    str = str.replaceAll("ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ", "u");
    str = str.replaceAll("ỳ|ý|ỵ|ỷ|ỹ", "y");
    str = str.replaceAll("đ", "d");

    str = str.replaceAll("À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ", "A");
    str = str.replaceAll("È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ", "E");
    str = str.replaceAll("Ì|Í|Ị|Ỉ|Ĩ", "I");
    str = str.replaceAll("Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ", "O");
    str = str.replaceAll("Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ", "U");
    str = str.replaceAll("Ỳ|Ý|Ỵ|Ỷ|Ỹ", "Y");
    str = str.replaceAll("Đ", "D");
    return str;
  }

  String? cityDropSelect;
  String city = '';
  String locationCode = '';
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
                          value: cityDropSelect,
                          onChanged: (value) {
                            List<String> values = (value.toString()).split('-');
                            setState(() {
                              cityDropSelect = value.toString();
                              city = values[0];
                              locationCode = values[1];
                            });
                          },
                          items: location.map((Locations newValue) {
                            return DropdownMenuItem(
                              value:
                                  '${newValue.name}-${newValue.locationCode}',
                              child: Text(newValue.name),
                            );
                          }).toList(),
                        ),
                        BoxInput(
                          title: 'Giá phòng',
                          inputDefault: InputDefault(
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
        if (cityDropSelect != null) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                title: Icon(Icons.check_circle,
                    size: 50, color: AppColors.primary),
                content: Text('Thành công', textAlign: TextAlign.center),
              );
            },
          );
          await BookingRepo.addHotels(
            nameHotelController.text,
            addHotelController.text,
            city,
            locationCode,
            int.parse(priceController.text),
            imageKS,
            adminAccount?.maCty ?? '',
            descriptionController.text,
            convert(nameHotelController.text),
          );
          Navigator.pop(context);
        }
      }
    }
  }

  void onTapEditHotel() async {
    if (formKey.currentState!.validate()) {
      if (user != null) {
        if (cityDropSelect != null) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                title: Icon(Icons.check_circle,
                    size: 50, color: AppColors.primary),
                content: Text('Thành công', textAlign: TextAlign.center),
              );
            },
          );
          await BookingRepo.editHotels(
            widget.hotel!.idKS,
            nameHotelController.text,
            addHotelController.text,
            city,
            locationCode,
            int.parse(priceController.text),
            imageKS,
            widget.hotel!.maKS,
            descriptionController.text,
            convert(nameHotelController.text),
          );

          Navigator.of(context).pop();
        }
      }
    }
  }
}
