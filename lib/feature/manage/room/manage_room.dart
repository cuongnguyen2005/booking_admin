// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:booking_admin/data/rooms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_admin/components/btn/button_icon.dart';
import 'package:booking_admin/components/dialog/dialog_primary.dart';
import 'package:booking_admin/components/top_bar/topbar_default.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/feature/manage/add_room.dart';
import 'package:booking_admin/feature/manage/room/bloc/room_bloc.dart';
import 'package:booking_admin/feature/manage/room/bloc/room_event.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';
import 'bloc/room_state.dart';

class RoomManage extends StatefulWidget {
  const RoomManage({
    Key? key,
    this.hotel,
  }) : super(key: key);
  final Hotels? hotel;
  static String routeName = 'room_manage';

  @override
  State<RoomManage> createState() => _RoomManageState();
}

class _RoomManageState extends State<RoomManage> {
  @override
  void initState() {
    super.initState();
    getListRoom();
  }

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state is RoomLoadingState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            },
          );
        }
        if (state is RoomRemoveLoadingState) {
          onTapBack();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            TopBarDefault(
              text: 'Quản lý phòng',
              onTap: onTapBack,
            ),
            Flexible(
              child: BlocBuilder<RoomBloc, RoomState>(
                builder: (context, state) {
                  List<Rooms> roomsList = state.roomsList;
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 24),
                    itemCount: roomsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => onTapEditRoom(index, roomsList),
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 24, left: 24, right: 24),
                          width: MediaQuery.of(context).size.width * 3 / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.white,
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.memory(
                                  base64.decode(roomsList[index].anhPhong),
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(roomsList[index].tenPhong,
                                            style: tStyle.MediumBoldBlack()),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: AppColors.yellow,
                                            ),
                                            const SizedBox(width: 8),
                                            Text('5.0',
                                                style:
                                                    tStyle.MediumBoldBlack()),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(roomsList[index].diaChi,
                                        style: tStyle.SmallRegular()),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('\$${roomsList[index].giaPhong}',
                                            style: tStyle.MediumBoldBlack()),
                                        ButtonIconWidget(
                                          icon: Icons.delete,
                                          onTap: () => onTapDeleteRoom(
                                              roomsList[index].idPhong),
                                          color: AppColors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            onTap: onTapAddRoom,
            child: const Icon(
              Icons.add,
              color: AppColors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapAddRoom() {
    Navigator.pushNamed(context, AddRoom.routeName,
        arguments: AddRoomArg(hotelBase: widget.hotel));
  }

  void onTapEditRoom(index, roomsList) {
    Navigator.pushNamed(context, AddRoom.routeName,
        arguments: AddRoomArg(room: roomsList[index]));
  }

  void getListRoom() {
    context.read<RoomBloc>().add(RoomGetHotelsListEvent(widget: widget));
  }

  void onTapDeleteRoom(key) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogPrimary(
          content: 'Bạn có muốn xoá phòng này không?',
          buttonText: 'Đồng ý',
          onTap: () async {
            await BookingRepo.deleteRooms(key);
            onTapBack();
            getListRoom();
          },
        );
      },
    );
  }
}
