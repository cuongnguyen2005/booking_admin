// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booking/components/bottom_sheet/bottom_sheet_secondary.dart';
import 'package:booking/components/box/search_box.dart';
import 'package:booking/data/hotels.dart';
import 'package:booking/data/location.dart';
import 'package:booking/data/reason.dart';
import 'package:booking/feature/user/home/bloc/home_bloc.dart';
import 'package:booking/feature/user/home/bloc/home_event.dart';
import 'package:booking/feature/user/home/widget/location_big_widget.dart';
import 'package:booking/feature/user/home/widget/select_person_roomtype.dart';
import 'package:booking/feature/user/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:booking/components/btn/button_icon.dart';
import 'package:booking/feature/user/detail_hotel/detail_hotel.dart';
import 'package:booking/source/colors.dart';
import 'package:booking/source/typo.dart';

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
    context.read<HomeBloc>().add(HomeGetHotelsList());
  }

  DateTimeRange selectedRangeDate = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
  );
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  int nguoi = 1;
  String nameLocation = 'Lựa chọn điểm đến';
  String kieuPhong = 'đơn';
  int soDem = 1;
  int soPhong = 1;
  String locationCode = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        List<Hotels> hotelList = state.hotelsList;
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/Herobanner.png',
                  fit: BoxFit.contain,
                ),
              ),
              //header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.gretting,
                      style: tStyle.H1(),
                    ),
                    const ButtonIconWidget(icon: Icons.notifications_rounded)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 110),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //search
                        SearchBox(
                          contentNameLocation: nameLocation,
                          contentDateTimeCheck:
                              '${DateFormat.yMd().format(startTime)} - ${DateFormat.yMd().format(endTime)}',
                          night: soDem,
                          contentSelectPersonAndRoomType:
                              'phòng $kieuPhong x $soPhong, $nguoi khách',
                          onTapShowLocation: onTapShowLocation,
                          onTapShowRangeTime: onTapShowRangeTime,
                          onTapSelectPeople: onTapSelectPeople,
                          onTapSearch: onTapSearch,
                        ),

                        //list popular location
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 24, left: 24, top: 24, bottom: 16),
                          child: Text('Lý do đặt phòng với Booking',
                              style: tStyle.MediumBoldBlack()),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 24),
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: reasons.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(right: 12),
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.primary,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(reasons[index].icon,
                                        size: 30, color: AppColors.white),
                                    const SizedBox(height: 10),
                                    Text(reasons[index].text,
                                        textAlign: TextAlign.center,
                                        style: tStyle.BaseRegularWhite())
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        //popular location
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 24, left: 24, top: 24, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Địa điểm phổ biến',
                                  style: tStyle.MediumBoldBlack()),
                              Text('Tất cả',
                                  style: tStyle.MediumRegularPrimary()),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(left: 24),
                          height: 350,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hotelList.length,
                            itemBuilder: (context, index) {
                              return HotelWidget(
                                image: base64.decode(hotelList[index].anhKS),
                                nameHotel: hotelList[index].tenKS,
                                addressHotel: hotelList[index].diaChi,
                                price: '\$${hotelList[index].giaKS}',
                                star: '5.0',
                                onTap: () => onTapDetail(index, hotelList),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //hàm hiển thị chi tiết khách sạn
  void onTapDetail(index, hotelList) {
    Navigator.pushNamed(
      context,
      DetailHotelPage.routeName,
      arguments: DetailHotelArg(
        hotel: hotelList[index],
        startDate: startTime,
        endDate: endTime,
        people: nguoi,
        roomType: kieuPhong,
        room: soPhong,
        night: soDem,
      ),
    );
  }

  //hàm thực hiện lựa chọn địa điểm
  void onTapShowLocation() {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 3 / 4,
          width: double.infinity,
          child: Column(
            children: [
              const BottomSheetSecondary(text: 'Chọn địa điểm'),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: location.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(location[index].name),
                      onTap: () {
                        setState(() {
                          nameLocation = location[index].name;
                          locationCode = location[index].locationCode;
                        });
                        onTapBack();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //hàm lựa ngày ngày nhận - trả phòng
  void onTapShowRangeTime() async {
    final DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      initialDateRange: selectedRangeDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (dateTimeRange != null) {
      setState(() {
        selectedRangeDate = dateTimeRange;
        startTime = dateTimeRange.start;
        endTime = dateTimeRange.end;
        soDem = dateTimeRange.duration.inDays;
      });
    }
  }

  //hàm lựa chọn loại phòng, số khách
  void onTapSelectPeople() {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return SelectPersonAndRoomType(
          people: nguoi,
          roomType: kieuPhong,
          room: soPhong,
          changePeople: (valuePeople) {
            nguoi = valuePeople;
            setState(() {});
          },
          changeRoomType: (valueRoomType) {
            kieuPhong = valueRoomType;
            setState(() {});
          },
          changeRoom: (valueRoom) {
            soPhong = valueRoom;
            setState(() {});
          },
        );
      },
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapSearch() {
    if (nameLocation != 'Lựa chọn điểm đến' &&
        nameLocation != 'Bạn chưa chọn điểm đến') {
      Navigator.pushNamed(
        context,
        SearchPage.routeName,
        arguments: SearchPageArg(
          nameLocation: nameLocation,
          startDate: startTime,
          endDate: endTime,
          people: nguoi,
          roomType: kieuPhong,
          room: soPhong,
          night: soDem,
          locationCode: locationCode,
        ),
      );
    } else {
      setState(() {
        nameLocation = "Bạn chưa chọn điểm đến";
      });
    }
  }
}
