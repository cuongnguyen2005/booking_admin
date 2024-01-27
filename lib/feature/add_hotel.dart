// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';
import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/select_widget/dropdown_select.dart';
import 'package:booking_admin/components/select_widget/radio_select.dart';
import 'package:booking_admin/components/text_field/box_input.dart';
import 'package:booking_admin/components/text_field/text_field_default.dart';
import 'package:booking_admin/components/top_bar/topbar_third.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/data/location.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class AddHotel extends StatefulWidget {
  const AddHotel({
    Key? key,
    this.hotel,
  }) : super(key: key);
  final Hotels? hotel;
  static String routeName = 'add_hotel';

  @override
  State<AddHotel> createState() => _AddHotelState();
}

class _AddHotelState extends State<AddHotel> {
  @override
  void initState() {
    super.initState();
    widget.hotel == null ? getImage() : image = widget.hotel?.anhKS ?? '';
    nameHotelController.text = widget.hotel?.tenKS ?? '';
    addHotelController.text = widget.hotel?.diaChi ?? '';
    city = widget.hotel?.thanhPho ?? '';
    locationCode = widget.hotel?.maDiaDiem ?? '';
    roomType = widget.hotel?.roomType ?? '';
    priceController.text = (widget.hotel?.giaKS ?? 0).toString();
    descriptionController.text = widget.hotel?.moTa ?? '';
  }

  User? user = FirebaseAuth.instance.currentUser;

  void getUser() {}

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
        setState(() {
          image = base64Image;
        });
      }
    } catch (e) {}
  }

  void getImage() async {
    ByteData bytes = await rootBundle.load('assets/images/avatar_white.jpg');
    final ByteBuffer buffer = bytes.buffer;
    setState(() {
      image = base64.encode(Uint8List.view(buffer));
    });
  }

  String? cityDropSelect;
  String city = '';
  String locationCode = '';
  String roomType = 'đơn';
  String image = '';
  final TextEditingController nameHotelController = TextEditingController();
  final TextEditingController addHotelController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          widget.hotel == null
              ? const TopBarThird(text: 'Thêm mới')
              : TopBarDefault(
                  text: 'Sửa',
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
                      BoxInput(
                        title: 'Tên khách sạn',
                        inputDefault: InputDefault(
                          hintText: 'Tên khách sạn',
                          obscureText: false,
                          controller: nameHotelController,
                        ),
                      ),
                      BoxInput(
                        title: 'Địa chỉ',
                        inputDefault: InputDefault(
                          hintText: 'Địa chỉ',
                          obscureText: false,
                          controller: addHotelController,
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
                            value: '${newValue.name}-${newValue.locationCode}',
                            child: Text(newValue.name),
                          );
                        }).toList(),
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
                      BoxInput(
                        title: 'Mô tả',
                        inputDefault: InputDefault(
                          hintText: 'Mô tả',
                          obscureText: false,
                          controller: descriptionController,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Thêm ảnh',
                                      style: tStyle.MediumBoldBlack()),
                                  const SizedBox(height: 16),
                                  ButtonPrimary(
                                    text: 'Thêm',
                                    onTap: () {
                                      pickImage();
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Image.memory(
                                    base64.decode(image),
                                    width: 150,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.all(16),
                  child: ButtonPrimary(
                    text: widget.hotel == null ? 'Thêm' : 'Sửa',
                    onTap: onTapAddHotel,
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
    Navigator.of(context);
  }

  void onTapAddHotel() async {
    if (user != null) {
      if (cityDropSelect != null) {
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
          locationCode,
          int.parse(priceController.text),
          image,
          roomType,
          '',
          '',
          user!.uid,
          descriptionController.text,
        );
        Navigator.pop(context);
        nameHotelController.clear();
        addHotelController.clear();
        priceController.clear();
      }
    }
  }
}
