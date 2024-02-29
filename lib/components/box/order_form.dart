// ignore_for_file: public_member_api_docs, sort_constructors_first
//dùng trong thông tin thanh toán, và thông tin đặt phòng
import 'package:flutter/material.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class OrderForm extends StatelessWidget {
  const OrderForm({
    Key? key,
    required this.nameHotel,
    required this.nameRoom,
    required this.dienTich,
    required this.night,
    required this.people,
    required this.roomType,
    required this.checkin,
    required this.checkout,
  }) : super(key: key);
  final String nameHotel;
  final String nameRoom;
  final String dienTich;
  final String night;
  final String people;
  final String roomType;
  final String checkin;
  final String checkout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: AppColors.primary),
          child: Row(
            children: [
              const Icon(
                Icons.other_houses,
                color: AppColors.white,
              ),
              const SizedBox(width: 8),
              Text(
                nameHotel,
                style: tStyle.BaseRegularWhite(),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.lightGrey),
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameRoom,
                style: tStyle.MediumBoldBlack(),
              ),
              const SizedBox(height: 5),
              Text(
                dienTich,
                style: tStyle.BaseRegularBlack(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.lightGrey),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              ListBundle(
                  icon: Icons.brightness_2, title: 'Số đêm', content: night),
              const SizedBox(height: 10),
              ListBundle(icon: Icons.people, title: 'Khách', content: people),
              const SizedBox(height: 8),
              ListBundle(
                  icon: Icons.bed_outlined,
                  title: 'Loại giường',
                  content: roomType),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.lightGrey),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              ListBundle(
                  icon: Icons.timer, title: 'Nhận phòng', content: checkin),
              const SizedBox(height: 10),
              ListBundle(
                  icon: Icons.timer, title: 'Trả phòng', content: checkout),
            ],
          ),
        ),
      ],
    );
  }
}

class ListBundle extends StatelessWidget {
  const ListBundle({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: tStyle.BaseRegularBlack()),
            const SizedBox(height: 5),
            Text(content, style: tStyle.BaseBoldBlack()),
          ],
        )
      ],
    );
  }
}
