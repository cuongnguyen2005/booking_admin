// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/data/hotels.dart';

class SearchState {
  List<Hotels> listHotelByCondition;
  SearchState({
    this.listHotelByCondition = const [],
  });
}

class SearchInitial extends SearchState {}

class SearchHaveResultsState extends SearchState {}

class SearchNoResultsState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchDeleteLoadingState extends SearchState {}
