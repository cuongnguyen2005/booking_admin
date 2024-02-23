import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  User? user = FirebaseAuth.instance.currentUser;
  HomeBloc() : super(HomeInitial()) {
    on<HomeGetHotelsEvent>((event, emit) async {
      emit(HomeLoadingState());
      List<Hotels> curHotelsList = [];
      List<Hotels> hotelsListAPI = await BookingRepo.getHotels();
      for (var element in hotelsListAPI) {
        if (element.maNV == user!.uid) {
          curHotelsList.add(element);
        }
      }
      emit(HomeRemoveLoadingState());
      emit(HomeState(hotelList: curHotelsList));
    });
  }
}
