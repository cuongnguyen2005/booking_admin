import 'package:booking_admin/data/admin_account.dart';
import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      AdminAccount? adminAccount;
      FirebaseFirestore.instance
          .collection('admins')
          .doc(user?.uid)
          .get()
          .then((value) {
        adminAccount = AdminAccount.fromMap(value.data());
      });
      List<Booking> listBookingApi = await BookingRepo.getBookingByUser();
      //sort list by date
      listBookingApi.sort((b, a) => a.ngayNhan.compareTo(b.ngayNhan));
      List<Booking> curListBooking = [];
      for (var element in listBookingApi) {
        if (element.ngayNhan.month == today.month &&
            element.ngayNhan.year == today.year &&
            element.maKS == adminAccount!.maKS) {
          curListBooking.add(element);
        }
      }
      emit(CalendarState(listBooking: curListBooking));
    });
  }
}
