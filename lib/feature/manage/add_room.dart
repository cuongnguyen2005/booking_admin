// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:booking_admin/data/rooms.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:booking_admin/source/utils/validate_util.dart';
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
    bedType = widget.arg.room?.loaiGiuong ?? 'đơn';
    priceController.text = (widget.arg.room?.giaPhong ?? '').toString();
    soLuongNguoi = widget.arg.room?.soLuongNguoi ?? 1;
    soLuongGiuong = widget.arg.room?.soLuongGiuong ?? 1;
    dienTichPhongController.text =
        (widget.arg.room?.dienTichPhong ?? '').toString();
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

  String bedType = 'đơn';
  String imageRoom = '';
  int soLuongNguoi = 1;
  int soLuongGiuong = 1;
  int dienTichPhong = 0;
  final TextEditingController nameHotelController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dienTichPhongController = TextEditingController();
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
                        groupValue: bedType,
                        onChanged1: (value) {
                          setState(() {
                            bedType = value.toString();
                          });
                        },
                        onChanged2: (value) {
                          setState(() {
                            bedType = value.toString();
                          });
                        },
                        title: 'Loại Giường',
                        value1: 'Đôi',
                        value2: 'Đơn',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Số lượng giường',
                            style: tStyle.MediumBoldBlack(),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (soLuongGiuong > 1) {
                                    setState(() {
                                      soLuongGiuong -= 1;
                                    });
                                  }
                                },
                                child: const Icon(Icons.remove),
                              ),
                              const SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('$soLuongGiuong'),
                              ),
                              const SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    soLuongGiuong += 1;
                                  });
                                },
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      BoxInput(
                        title: 'Diện tích phòng',
                        inputDefault: InputDefault(
                          keyboardType: TextInputType.number,
                          hintText: 'Diện tích phòng',
                          obscureText: false,
                          controller: dienTichPhongController,
                          validator: ValidateUntils.validateName,
                          autovalidateMode: AutovalidateMode.disabled,
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Số lượng người tối đa',
                            style: tStyle.MediumBoldBlack(),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (soLuongNguoi > 1) {
                                    setState(() {
                                      soLuongNguoi -= 1;
                                    });
                                  }
                                },
                                child: const Icon(Icons.remove),
                              ),
                              const SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('$soLuongNguoi'),
                              ),
                              const SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    soLuongNguoi += 1;
                                  });
                                },
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
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
        int.parse(priceController.text),
        bedType,
        soLuongGiuong,
        imageRoom,
        soLuongNguoi,
        int.parse(dienTichPhongController.text),
        widget.arg.hotelBase?.idKS ?? '',
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      nameHotelController.clear();
      priceController.clear();
      imageRoom = '';
      soLuongNguoi = 1;
      soLuongGiuong = 1;
      dienTichPhong = 0;
      setState(() {});
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
        int.parse(priceController.text),
        bedType,
        soLuongGiuong,
        imageRoom,
        soLuongNguoi,
        int.parse(dienTichPhongController.text),
        widget.arg.room?.idKS ?? '',
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
