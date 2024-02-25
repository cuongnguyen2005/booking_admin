// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:booking_admin/data/rooms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/select_widget/radio_select.dart';
import 'package:booking_admin/components/text_field/box_input.dart';
import 'package:booking_admin/components/text_field/text_field_default.dart';
import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:booking_admin/source/colors.dart';

class AddRoomArg {
  final Rooms? room;
  final Hotels? hotelBase;
  AddRoomArg({
    this.room,
    this.hotelBase,
  });
}

class AddRoom extends StatefulWidget {
  const AddRoom({
    Key? key,
    required this.arg,
  }) : super(key: key);
  final AddRoomArg arg;

  static String routeName = 'add_hotel';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  @override
  void initState() {
    super.initState();
    imageRoom = widget.arg.room?.anhPhong ?? '';
    nameHotelController.text = widget.arg.room?.tenPhong ?? '';
    roomType = widget.arg.room?.kieuPhong ?? '';
    priceController.text = (widget.arg.room?.giaPhong ?? 0).toString();
  }

  User? user = FirebaseAuth.instance.currentUser;
  String imageUrl = '';

  //chọn ảnh
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
        imageRoom = imageUrl;
      });
    } catch (e) {
      //some error
    }
  }

  String roomType = 'đơn';
  String imageRoom = '';
  final TextEditingController nameHotelController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarDefault(
            text: widget.arg.room == null ? 'Thêm mới' : 'Sửa',
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
                  child: Column(
                    children: [
                      Stack(children: [
                        imageRoom == ''
                            ? Container(
                                height: 250,
                                color: AppColors.grey.withOpacity(0.5),
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: 250,
                                child: Image.network(
                                  imageRoom,
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
                              // borderRadius: BorderRadius.circular(20),
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
                        title: 'Tên phòng',
                        inputDefault: InputDefault(
                          hintText: 'Tên phòng',
                          obscureText: false,
                          controller: nameHotelController,
                        ),
                      ),
                      RadioSelect(
                        groupValue: roomType,
                        onChanged1: (value) {
                          setState(() {
                            roomType = value.toString();
                          });
                        },
                        onChanged2: (value) {
                          setState(() {
                            roomType = value.toString();
                          });
                        },
                        title: 'Loại phòng',
                        value1: 'Đôi',
                        value2: 'Đơn',
                      ),
                      BoxInput(
                        title: 'Giá phòng',
                        inputDefault: InputDefault(
                          hintText: 'Giá phòng',
                          obscureText: false,
                          controller: priceController,
                        ),
                      ),
                      // BoxInput(
                      //   title: 'Mô tả',
                      //   inputDefault: InputDefault(
                      //     hintText: 'Mô tả',
                      //     obscureText: false,
                      //     controller: descriptionController,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.all(16),
                  child: ButtonPrimary(
                    text: widget.arg.room == null ? 'Thêm' : 'Sửa',
                    onTap:
                        widget.arg.room == null ? onTapAddRoom : onTapEditRoom,
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

  void onTapAddRoom() async {
    if (user != null) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            title: Icon(Icons.check_circle, size: 50, color: AppColors.primary),
            content: Text('Thành công', textAlign: TextAlign.center),
          );
        },
      );
      await BookingRepo.addRooms(
        nameHotelController.text,
        widget.arg.hotelBase?.diaChi ?? '',
        widget.arg.hotelBase?.thanhPho ?? '',
        int.parse(priceController.text),
        roomType,
        imageRoom,
        widget.arg.hotelBase?.idKS ?? '',
        widget.arg.hotelBase?.maKS ?? '',
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      nameHotelController.clear();
      priceController.clear();
      imageRoom = '';
    }
  }

  void onTapEditRoom() async {
    if (user != null) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            title: Icon(Icons.check_circle, size: 50, color: AppColors.primary),
            content: Text('Thành công', textAlign: TextAlign.center),
          );
        },
      );
      await BookingRepo.editRooms(
        widget.arg.room?.idPhong ?? '',
        nameHotelController.text,
        widget.arg.room?.diaChi ?? '',
        widget.arg.room?.thanhPho ?? '',
        int.parse(priceController.text),
        roomType,
        imageRoom,
        widget.arg.room?.idKS ?? '',
        widget.arg.room?.maKS ?? '',
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
