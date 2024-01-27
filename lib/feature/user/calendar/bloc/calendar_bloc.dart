import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  User? user = FirebaseAuth.instance.currentUser;
  DateTime today = DateTime.now();
  String status = '';
  CalendarBloc() : super(CalendarInitial()) {
    on<CalendarEvent>((event, emit) {});
    on<CalendarGetDataEvent>((event, emit) async {
      List<Booking> listBookingApi = await BookingRepo.getBookingByUser();
      List<Booking> curListBooking = [];
      for (var element in listBookingApi) {
        if (element.ngayNhan.month == today.month &&
            element.ngayNhan.year == today.year &&
            element.idUser == user!.uid) {
          curListBooking.add(element);
        }
      }
      emit(CalendarState(listBooking: curListBooking));
    });
  }
}
