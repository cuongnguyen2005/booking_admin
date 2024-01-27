// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/data/favorite_hotel.dart';

class DetailHotelState {
  List<FavoriteHotel> favoriteHotel;
  DetailHotelState({
    this.favoriteHotel = const [],
  });
}

class DetailHotelInitial extends DetailHotelState {}
