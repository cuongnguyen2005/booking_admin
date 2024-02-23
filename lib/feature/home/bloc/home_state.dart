import 'package:booking_admin/data/hotels.dart';

class HomeState {
  List<Hotels> hotelList;
  HomeState({
    this.hotelList = const [],
  });
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRemoveLoadingState extends HomeState {}
