// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/data/hotels.dart';

class HomeState {
  List<Hotels> hotelsList;
  HomeState({
    this.hotelsList = const [],
  });
}

class HomeInitial extends HomeState {}
