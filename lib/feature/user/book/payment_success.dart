// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/feature/user/bottom_navi.dart';
import 'package:flutter/material.dart';
import 'package:booking_admin/components/box/info_box.dart';
import 'package:booking_admin/components/btn/button_outline.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({
    Key? key,
    required this.totalMoney,
  }) : super(key: key);
  final int totalMoney;
  static String routeName = 'payment_success';

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 100,
            ),
            Image.asset('assets/images/payment.png'),
            const SizedBox(height: 10),
            Text('Đặt phòng thành công!', style: tStyle.MediumBoldGreen()),
            const SizedBox(height: 24),
            const InfoBox(title: 'Thông tin thanh toán', content: 'Trực tiếp'),
            const SizedBox(height: 10),
            InfoBox(title: 'Số tiền', content: '${widget.totalMoney} đ'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ButtonOutline(
                    text: 'Về trang chủ',
                    onTap: onTapBackHome,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ButtonPrimary(
                    text: 'Chi tiết đặt chỗ',
                    onTap: onTapDetailBooking,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onTapBackHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, BottomNavi.routeName, (route) => false);
  }

  void onTapDetailBooking() {}
}
