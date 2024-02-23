import 'package:booking_admin/data/rooms.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'room_event.dart';
import 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final DateTime dateTime = DateTime.now();
  RoomBloc() : super(RoomInitial()) {
    on<RoomEvent>((event, emit) {});
    on<RoomGetHotelsListEvent>((event, emit) async {
      emit(RoomLoadingState());
      List<Rooms> curRoomsList = [];
      List<Rooms> roomsListAPI = await BookingRepo.getRooms();
      for (var element in roomsListAPI) {
        if (element.idKS == event.widget.hotel!.idKS) {
          curRoomsList.add(element);
        }
      }
      emit(RoomRemoveLoadingState());
      emit(RoomState(roomsList: curRoomsList));
    });
  }
}
