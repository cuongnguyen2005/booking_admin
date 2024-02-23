// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/feature/manage/room/manage_room.dart';

class RoomEvent {}

class RoomGetHotelsListEvent extends RoomEvent {
  RoomManage widget;
  RoomGetHotelsListEvent({
    required this.widget,
  });
}
