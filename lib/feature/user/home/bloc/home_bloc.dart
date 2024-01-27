import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DateTime dateTime = DateTime.now();
  String gretting = '';
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeGetHotelsList>((event, emit) async {
      List<Hotels> curHotelsList = await BookingRepo.getHotels();
      //gretting
      if (dateTime.hour <= 10) {
        gretting = 'Xin chào buổi sáng!';
      } else if (dateTime.hour <= 13) {
        gretting = 'Xin chào buổi trưa!';
      } else if (dateTime.hour <= 17) {
        gretting = 'Xin chào buổi chiều!';
      } else {
        gretting = 'Xin chào buổi tối!';
      }
      emit(HomeState(gretting: gretting, hotelsList: curHotelsList));
    });
  }
}
