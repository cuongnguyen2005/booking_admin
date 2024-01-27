// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/data/hotels.dart';

class HomeState {
  String gretting;
  List<Hotels> hotelsList;
  HomeState({
    this.gretting = '',
    this.hotelsList = const [],
  });
}

class HomeInitial extends HomeState {}
