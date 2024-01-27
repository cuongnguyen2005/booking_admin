// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/feature/user/book/customer_info.dart';

class BookingEvent {}

class BookingGetTotalMoneyEvent extends BookingEvent {
  CustomerInfo widget;
  BookingGetTotalMoneyEvent({
    required this.widget,
  });
}
