import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/data/admin_account.dart';
import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/feature/detail_payment.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/number_format.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tiengviet/tiengviet.dart';

import '../components/text_field/text_field_default.dart';

class SearchBookingPage extends StatefulWidget {
  const SearchBookingPage({super.key});
  static String routeName = 'search_booking_page';

  @override
  State<SearchBookingPage> createState() => _SearchBookingPageState();
}

class _SearchBookingPageState extends State<SearchBookingPage> {
  @override
  void initState() {
    super.initState();
    getAdmin();
    // getBookingList();
  }

  User? user = FirebaseAuth.instance.currentUser;
  AdminAccount? adminAccount;
  void getAdmin() {
    FirebaseFirestore.instance
        .collection('admins')
        .doc(user?.uid)
        .get()
        .then((value) {
      adminAccount = AdminAccount.fromMap(value.data());
    });
  }

  List<Booking> bookingList = [];
  void getBookingList(String value) async {
    List<Booking> listBookingApi = await BookingRepo.getBookingByUser();

    List<Booking> curListBooking = [];
    for (var element in listBookingApi) {
      if (element.maKS == adminAccount!.maCty) {
        curListBooking.add(element);
      }
    }
    setState(() {
      bookingList = curListBooking
          .where((element) => (TiengViet.parse(element.tenPhong))
              .toLowerCase()
              .contains((TiengViet.parse(value)).toLowerCase()))
          .toList();
    });
  }

  String status = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarDefault(text: 'Tìm kiếm đặt phòng', onTap: onTapBack),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: InputDefault(
              hintText: 'Tìm kiếm đặt phòng theo tên phòng',
              obscureText: false,
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) => getBookingList(value),
            ),
          ),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: bookingList.length,
              itemBuilder: (context, index) {
                List<String> statusList = [];
                for (var element in bookingList) {
                  if (element.trangThai == 2) {
                    status = 'Đang xử lý';
                  } else if (element.trangThai == 1) {
                    status = ' Đã từ chối';
                  } else if (element.trangThai == 0) {
                    status = 'Thành công';
                  }
                  statusList.add(status);
                }
                return InkWell(
                  onTap: () => onTapDetailPayment(index, bookingList),
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: bookingList[index].trangThai == 2
                                ? AppColors.yellow.withOpacity(0.2)
                                : bookingList[index].trangThai == 1
                                    ? AppColors.red.withOpacity(0.2)
                                    : AppColors.green.withOpacity(0.2),
                          ),
                          child: Text(statusList[index],
                              style: bookingList[index].trangThai == 2
                                  ? tStyle.BaseRegularYellow()
                                  : bookingList[index].trangThai == 1
                                      ? tStyle.BaseRegularRed()
                                      : tStyle.BaseRegularGreen()),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                                width: 1, color: AppColors.lightGrey),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.home),
                                  const SizedBox(width: 10),
                                  Text(bookingList[index].tenPhong,
                                      style: tStyle.BaseBoldBlack()),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                  'Ngày đặt: ${DateFormat.yMd().format(bookingList[index].ngayNhan)}')
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 12),
                          width: double.infinity,
                          child: Text(
                            '${NumberFormatUnity.priceFormat(bookingList[index].thanhTien)} đ',
                            style: tStyle.BaseBoldPrimary(),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapDetailPayment(index, bookingList) {
    Navigator.pushNamed(context, DetailPayment.routeName,
            arguments: bookingList[index])
        .then((value) => getBookingList);
  }
}
