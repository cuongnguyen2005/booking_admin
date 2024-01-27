// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking/data/booking.dart';

class CalendarState {
  List<Booking> listBooking;
  CalendarState({
    this.listBooking = const [],
  });
}

class CalendarInitial extends CalendarState {}
