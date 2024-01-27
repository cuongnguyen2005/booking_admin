// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Reason {
  IconData icon;
  String text;
  Reason({
    required this.icon,
    required this.text,
  });
}

List<Reason> reasons = [
  Reason(icon: Icons.home, text: 'Miễn phí đặt phòng'),
  Reason(icon: Icons.money, text: 'Thanh toán tại khách sạn'),
  Reason(icon: Icons.home, text: 'Tích xu sau mỗi giao dịch'),
  Reason(icon: Icons.home, text: 'Hỗ trợ 24/7'),
];
