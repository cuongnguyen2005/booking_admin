// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/feature/user/search/search_page.dart';

class SearchEvent {}

class SearchGetHotelEvent extends SearchEvent {
  SearchPage widget;
  SearchGetHotelEvent({
    required this.widget,
  });
}
