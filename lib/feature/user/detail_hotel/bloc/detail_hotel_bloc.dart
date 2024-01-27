import 'package:booking/data/favorite_hotel.dart';
import 'package:booking/source/call_api/booking_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_hotel_event.dart';
import 'detail_hotel_state.dart';

class DetailHotelBloc extends Bloc<DetailHotelEvent, DetailHotelState> {
  User? user = FirebaseAuth.instance.currentUser;
  DetailHotelBloc() : super(DetailHotelInitial()) {
    on<DetailHotelEvent>((event, emit) {});
    on<DetailHotelGetApiEvent>((event, emit) async {
      List<FavoriteHotel> listFavoriteHotelApi =
          await BookingRepo.getFavoriteHotelByUser(user!.uid);
      emit(DetailHotelState(favoriteHotel: listFavoriteHotelApi));
    });
  }
}
