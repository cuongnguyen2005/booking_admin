// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/data/rooms.dart';
import 'package:booking_admin/source/number_format.dart';
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
                              bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.white,
                              border: Border.all(
                                  width: 1,
                                  color: AppColors.grey.withOpacity(0.5))),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: roomsList[index].anhPhong == ''
                                          ? Container(
                                              width: 80,
                                              height: 80,
                                              color: AppColors.grey
                                                  .withOpacity(0.5),
                                            )
                                          : Image.network(
                                              roomsList[index].anhPhong,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        roomsList[index].tenPhong,
                                        style: tStyle.MediumBoldBlack(),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: AppColors.lightGrey,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.bed,
                                          color: AppColors.grey,
                                          size: 25,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                            '${roomsList[index].soLuongGiuong} giường ${roomsList[index].loaiGiuong}',
                                            style: tStyle.MediumRegularBlack()),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.people,
                                          color: AppColors.grey,
                                          size: 25,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                            '${roomsList[index].soLuongNguoi} người',
                                            style: tStyle.MediumRegularBlack()),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.rule,
                                          color: AppColors.grey,
                                          size: 25,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                            '${roomsList[index].dienTichPhong} m2',
                                            style: tStyle.MediumRegularBlack()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: AppColors.lightGrey,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: AppColors.green,
                                          size: 25,
                                        ),
                                        const SizedBox(width: 5),
                                        Text('Bữa sáng miễn phí',
                                            style: tStyle.BaseRegularBlack()),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: AppColors.green,
                                          size: 25,
                                        ),
                                        const SizedBox(width: 5),
                                        Text('Không hoàn tiền',
                                            style: tStyle.BaseRegularBlack()),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: AppColors.green,
                                          size: 25,
                                        ),
                                        const SizedBox(width: 5),
                                        Text('Wifi miễn phí',
                                            style: tStyle.BaseRegularBlack()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: AppColors.lightGrey,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${NumberFormatUnity.priceFormat(roomsList[index].giaPhong)} đ',
                                        style: tStyle.MediumBoldPrimary()),
                                    ButtonIconWidget(
                                      icon: Icons.delete,
                                      onTap: () => onTapDeleteRoom(
                                          roomsList[index].idPhong),
                                      color: AppColors.red,
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
            arguments: AddRoomArg(hotelBase: widget.hotel))
        .then((value) => getListRoom());
  }

  void onTapEditRoom(index, roomsList) {
    Navigator.pushNamed(context, AddRoom.routeName,
            arguments: AddRoomArg(room: roomsList[index]))
        .then((value) => getListRoom());
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
