// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:booking_admin/components/box/info_box.dart';
import 'package:booking_admin/components/box/order_form.dart';
import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class DetailPaymentArg {
  final String nameHotel;
  final int giaPhong;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime startDate;
  final DateTime endDate;
  final int people;
  final String roomType;
  final int room;
  final int night;
  final int totalMoney;
  final int trangThai;
  DetailPaymentArg({
    required this.nameHotel,
    required this.giaPhong,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.startDate,
    required this.endDate,
    required this.people,
    required this.roomType,
    required this.room,
    required this.night,
    required this.totalMoney,
    required this.trangThai,
  });
}

class DetailPayment extends StatefulWidget {
  const DetailPayment({
    Key? key,
    required this.arg,
  }) : super(key: key);
  final DetailPaymentArg arg;
  static String routeName = 'detail_payment';

  @override
  State<DetailPayment> createState() => _DetailPaymentState();
}

class _DetailPaymentState extends State<DetailPayment> {
  @override
  void initState() {
    super.initState();
    getStatusText();
  }

  void getStatusText() {
    if (widget.arg.trangThai == 2) {
      status = 'Đang xử lý';
    } else if (widget.arg.trangThai == 1) {
      status = 'Từ chối';
    } else if (widget.arg.trangThai == 0) {
      status = 'Thành công';
    }
  }

  String status = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarDefault(
            text: 'Thông tin thanh toán',
            onTap: onTapBack,
          ),
          //
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: widget.arg.trangThai == 2
                              ? AppColors.yellow.withOpacity(0.2)
                              : AppColors.green.withOpacity(0.2),
                        ),
                        child: Text(
                          status,
                          style: widget.arg.trangThai == 2
                              ? tStyle.BaseRegularYellow()
                              : tStyle.BaseRegularGreen(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      OrderForm(
                        nameHotel: widget.arg.nameHotel,
                        night: '${widget.arg.night} đêm',
                        people: '${widget.arg.people}  người',
                        roomType:
                            '${widget.arg.roomType}   x ${widget.arg.room}',
                        checkin:
                            '${DateFormat.yMd().format(widget.arg.startDate)} (15:00 - 03:00)',
                        checkout:
                            '${DateFormat.yMd().format(widget.arg.endDate)} (trước 11:00)',
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thông tin khách hàng',
                        style: tStyle.BaseBoldBlack(),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tên khách',
                                  style: tStyle.BaseRegularBlack()),
                              const SizedBox(height: 5),
                              Text(widget.arg.name,
                                  style: tStyle.BaseBoldBlack()),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thông tin liên hệ',
                        style: tStyle.BaseBoldBlack(),
                      ),
                      const SizedBox(height: 16),
                      InfoBox(title: 'Họ tên', content: widget.arg.name),
                      const SizedBox(height: 10),
                      InfoBox(
                          title: 'Số điện thoại',
                          content: widget.arg.phoneNumber),
                      const SizedBox(height: 10),
                      InfoBox(title: 'Email', content: widget.arg.email),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chi tiết giá',
                        style: tStyle.BaseBoldBlack(),
                      ),
                      const SizedBox(height: 16),
                      InfoBox(
                          title: 'Giá phòng',
                          content: '${widget.arg.giaPhong} đ'),
                      const SizedBox(height: 10),
                      InfoBox(
                          title: 'Số phòng', content: 'x ${widget.arg.room}'),
                      const SizedBox(height: 10),
                      InfoBox(
                          title: 'Số đêm', content: 'x ${widget.arg.night}'),
                      const SizedBox(height: 10),
                      InfoBox(
                          title: 'Tổng số tiền',
                          content: '${widget.arg.totalMoney} đ'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
