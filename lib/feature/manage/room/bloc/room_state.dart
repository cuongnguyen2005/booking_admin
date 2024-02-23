// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/data/rooms.dart';

class RoomState {
  List<Rooms> roomsList;
  RoomState({
    this.roomsList = const [],
  });
}

class RoomInitial extends RoomState {}

class RoomLoadingState extends RoomState {}

class RoomRemoveLoadingState extends RoomState {}
