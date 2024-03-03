// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/data/admin_account.dart';
import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class StatisPage extends StatefulWidget {
  const StatisPage({super.key});
  static String routeName = 'statis_page';

  @override
  State<StatisPage> createState() => _StatisPageState();
}

class _StatisPageState extends State<StatisPage> {
  @override
  void initState() {
    super.initState();
    getBookingList();
  }

  User? user = FirebaseAuth.instance.currentUser;
  AdminAccount? adminAccount;
  List<Booking> bookingList = [];
  void getBookingList() async {
    FirebaseFirestore.instance
        .collection('admins')
        .doc(user?.uid)
        .get()
        .then((value) {
      setState(() {
        adminAccount = AdminAccount.fromMap(value.data());
      });
    });
    List<Booking> hotelListApi = await BookingRepo.getBookingByUser();
    for (var element in hotelListApi) {
      if (element.maKS == adminAccount!.maKS) {
        setState(() {
          bookingList.add(element);
        });
        countBooking += 1;
      }
    }
    //get status
    for (var element in bookingList) {
      if (element.trangThai == 2) {
        countBookingLoading += 1;
      }
      if (element.trangThai == 1) {
        countBookingFaile += 1;
      }
      if (element.trangThai == 0) {
        countBookingSuccess += 1;
      }
    }
  }

  int countBooking = 0;
  int countBookingLoading = 0;
  int countBookingSuccess = 0;
  int countBookingFaile = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarDefault(
            text: 'Thống kê',
            onTap: onTapBack,
          ),
          Flexible(
            child: Column(
              children: [
                StatisWidget(
                  text: 'Số lượng đơn đặt phòng của khách sạn: ',
                  info: '$countBooking',
                ),
                StatisWidget(
                  text: 'Số lượng đơn đặt phòng khách sạn đang chờ xử lý: ',
                  info: '$countBookingLoading',
                ),
                StatisWidget(
                  text:
                      'Số lượng đơn đặt phòng khách sạn đã xử lý thành công: ',
                  info: '$countBookingSuccess',
                ),
                StatisWidget(
                  text: 'Số lượng đơn đặt phòng khách sạn bị từ chối: ',
                  info: '$countBookingFaile',
                ),
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
}

class StatisWidget extends StatelessWidget {
  const StatisWidget({
    Key? key,
    required this.text,
    required this.info,
  }) : super(key: key);
  final String text;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 10, left: 10, top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        text: TextSpan(
          text: text,
          style: tStyle.MediumRegularBlack(),
          children: <TextSpan>[
            TextSpan(text: info, style: tStyle.MediumBoldPrimary()),
          ],
        ),
      ),
    );
  }
}
