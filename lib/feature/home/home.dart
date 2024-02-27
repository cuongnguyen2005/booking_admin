// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_admin/components/dialog/dialog_primary.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/feature/manage/add_hotel.dart';
import 'package:booking_admin/feature/manage/room/manage_room.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/number_format.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/btn/button_icon.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getGreeting();
    getHotelList();
  }

  //gretting
  void getGreeting() {
    if (dateTime.hour <= 10) {
      gretting = 'Xin chào buổi sáng!';
    } else if (dateTime.hour <= 13) {
      gretting = 'Xin chào buổi trưa!';
    } else if (dateTime.hour <= 17) {
      gretting = 'Xin chào buổi chiều!';
    } else {
      gretting = 'Xin chào buổi tối!';
    }
  }

  void getHotelList() {
    context.read<HomeBloc>().add(HomeGetHotelsEvent());
  }

  DateTime dateTime = DateTime.now();
  String gretting = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/Herobanner.png',
              fit: BoxFit.contain,
            ),
          ),

          //content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 65),
                child: Text(gretting, style: tStyle.H1()),
              ),
              BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is HomeLoadingState) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primary),
                        );
                      },
                    );
                  }
                  if (state is HomeRemoveLoadingState) {
                    onTapBack();
                  }
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    List<Hotels> hotelList = state.hotelList;
                    return Flexible(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: hotelList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => onTapMoveManageRoom(index, hotelList),
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
                                    child: hotelList[index].anhKS == ''
                                        ? Container(
                                            height: 250,
                                            width: double.infinity,
                                            color:
                                                AppColors.grey.withOpacity(0.5),
                                          )
                                        : Image.network(
                                            hotelList[index].anhKS,
                                            height: 250,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(hotelList[index].tenKS,
                                                style:
                                                    tStyle.MediumBoldBlack()),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: AppColors.yellow,
                                                ),
                                                const SizedBox(width: 8),
                                                Text('5.0',
                                                    style: tStyle
                                                        .MediumBoldBlack()),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(hotelList[index].diaChi,
                                            style: tStyle.SmallRegular()),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${NumberFormatUnity.priceFormat(hotelList[index].giaKS)} đ',
                                                style:
                                                    tStyle.MediumBoldBlack()),
                                            Row(
                                              children: [
                                                ButtonIconWidget(
                                                  icon: Icons.edit,
                                                  onTap: () => onTapEditHotel(
                                                      hotelList, index),
                                                  color: AppColors.primary,
                                                ),
                                                const SizedBox(width: 10),
                                                ButtonIconWidget(
                                                  icon: Icons.delete,
                                                  onTap: () => onTapDeleteHotel(
                                                      hotelList[index].idKS),
                                                  color: AppColors.red,
                                                ),
                                              ],
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
                      ),
                    );
                  },
                ),
              )
            ],
          )
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
          onTap: onTapAddHotel,
          child: const Icon(
            Icons.add,
            color: AppColors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapAddHotel() {
    Navigator.pushNamed(context, AddHotel.routeName)
        .then((value) => getHotelList());
  }

  void onTapMoveManageRoom(index, hotelList) {
    Navigator.pushNamed(context, RoomManage.routeName,
        arguments: hotelList[index]);
  }

  void onTapDeleteHotel(key) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogPrimary(
          content: 'Bạn có muốn xoá Khách sạn này không?',
          buttonText: 'Đồng ý',
          onTap: () async {
            await BookingRepo.deleteHotel(key);
            onTapBack();
            getHotelList();
          },
        );
      },
    );
  }

  void onTapEditHotel(hotelList, index) {
    Navigator.pushNamed(context, AddHotel.routeName,
            arguments: hotelList[index])
        .then((value) => getHotelList());
  }
}
