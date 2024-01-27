import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  BookingBloc() : super(BookingInitial()) {
    on<BookingEvent>((event, emit) {});
    on<BookingGetTotalMoneyEvent>((event, emit) {
      int totalMoneyBloc = event.widget.arg.hotel.giaKS *
          event.widget.arg.night *
          event.widget.arg.room;
      emit(BookingState(totalMoney: totalMoneyBloc));
    });
  }
}
