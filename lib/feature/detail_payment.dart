// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:booking_admin/components/box/info_box.dart';
import 'package:booking_admin/components/box/order_form.dart';
import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class DetailPayment extends StatefulWidget {
  const DetailPayment({
    Key? key,
    required this.booking,
  }) : super(key: key);
  final Booking? booking;
  static String routeName = 'detail_payment';

  @override
  State<DetailPayment> createState() => _DetailPaymentState();
}

class _DetailPaymentState extends State<DetailPayment> {
  @override
  void initState() {
    super.initState();
    getStatusText();
    statusCode = widget.booking?.trangThai;
  }

  void getStatusText() {
    if (widget.booking?.trangThai == 2) {
      statusName = 'Đang xử lý';
    } else if (widget.booking?.trangThai == 1) {
      statusName = 'Đã từ chối';
    } else if (widget.booking?.trangThai == 0) {
      statusName = 'Thành công';
    }
  }

  String statusName = '';
  int? statusCode;
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
                          color: widget.booking?.trangThai == 2
                              ? AppColors.yellow.withOpacity(0.2)
                              : widget.booking?.trangThai == 1
                                  ? AppColors.red.withOpacity(0.2)
                                  : AppColors.green.withOpacity(0.2),
                        ),
                        child: Text(
                          statusName,
                          style: widget.booking?.trangThai == 2
                              ? tStyle.BaseRegularYellow()
                              : widget.booking?.trangThai == 1
                                  ? tStyle.BaseRegularRed()
                                  : tStyle.BaseRegularGreen(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      OrderForm(
                        nameHotel: widget.booking!.tenPhong,
                        night: '${widget.booking?.soDem} đêm',
                        people: '${widget.booking?.soNguoi}  người',
                        roomType:
                            'Phòng ${widget.booking?.kieuPhong}   x ${widget.booking?.soPhong}',
                        checkin:
                            '${DateFormat.yMd().format(widget.booking!.ngayNhan)} (15:00 - 03:00)',
                        checkout:
                            '${DateFormat.yMd().format(widget.booking!.ngayTra)} (trước 11:00)',
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
                              Text(widget.booking!.hoTen,
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
                      InfoBox(title: 'Họ tên', content: widget.booking!.hoTen),
                      const SizedBox(height: 10),
                      InfoBox(
                          title: 'Số điện thoại', content: widget.booking!.sdt),
                      const SizedBox(height: 10),
                      InfoBox(title: 'Email', content: widget.booking!.email),
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
                          content: '${widget.booking?.giaKS} đ'),
                      const SizedBox(height: 10),
                      InfoBox(
                          title: 'Số phòng',
                          content: 'x ${widget.booking?.soPhong}'),
                      const SizedBox(height: 10),
                      InfoBox(
                          title: 'Số đêm',
                          content: 'x ${widget.booking?.soDem}'),
                      const SizedBox(height: 10),
                      InfoBox(
                          title: 'Tổng số tiền',
                          content: '${widget.booking?.thanhTien} đ'),
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
                        Text('Cập nhật trạng thái',
                            style: tStyle.BaseBoldBlack()),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: 0,
                                groupValue: statusCode,
                                title: const Text('Chấp nhận'),
                                onChanged: (value) {
                                  setState(() {
                                    statusCode = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: 1,
                                groupValue: statusCode,
                                title: const Text('Từ chối'),
                                onChanged: (value) {
                                  setState(() {
                                    statusCode = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        Text('Lý do từ chối', style: tStyle.BaseBoldBlack()),
                      ],
                    )),
                if (statusCode != 0 || statusCode != 1)
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: ButtonPrimary(
                      text: 'Cập nhật',
                      onTap: statusCode == 2 ? onTapUpdateStatus : onTapNull,
                    ),
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

  void onTapUpdateStatus() async {
    print('object');
    await BookingRepo.editBooking(
      widget.booking!.idBooking,
      widget.booking!.idUser,
      widget.booking!.hoTen,
      widget.booking!.email,
      widget.booking!.sdt,
      widget.booking!.ngayNhan,
      widget.booking!.ngayTra,
      widget.booking!.soDem,
      widget.booking!.soNguoi,
      widget.booking!.soPhong,
      widget.booking!.thanhTien,
      widget.booking!.tenKS,
      widget.booking!.tenPhong,
      widget.booking!.giaKS,
      widget.booking!.kieuPhong,
      widget.booking!.maKS,
      statusCode!,
    );
  }

  void onTapNull() {}
}
