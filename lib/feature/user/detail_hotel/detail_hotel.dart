// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:booking_admin/components/dialog/dialog_primary.dart';
import 'package:booking_admin/data/favorite_hotel.dart';
import 'package:booking_admin/feature/user/detail_hotel/bloc/detail_hotel_bloc.dart';
import 'package:booking_admin/feature/user/login/login.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:flutter/material.dart';
import 'package:booking_admin/components/bottom_sheet/bottom_sheet_default.dart';
import 'package:booking_admin/components/top_bar/topbar_no_background.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/feature/user/book/customer_info.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/detail_hotel_event.dart';
import 'bloc/detail_hotel_state.dart';

class DetailHotelArg {
  final Hotels hotel;
  final DateTime startDate;
  final DateTime endDate;
  final int people;
  final String roomType;
  final int room;
  final int night;
  DetailHotelArg({
    required this.hotel,
    required this.startDate,
    required this.endDate,
    required this.people,
    required this.roomType,
    required this.room,
    required this.night,
  });
}

class DetailHotelPage extends StatefulWidget {
  const DetailHotelPage({
    Key? key,
    required this.arg,
  }) : super(key: key);
  static String routeName = 'detail_hotel_page';
  final DetailHotelArg arg;

  @override
  State<DetailHotelPage> createState() => _DetailHotelPageState();
}

class _DetailHotelPageState extends State<DetailHotelPage> {
  @override
  initState() {
    super.initState();
    context.read<DetailHotelBloc>().add(DetailHotelGetApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 5,
                child: Image.memory(
                  base64.decode(widget.arg.hotel.anhKS),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              //content
              BlocBuilder<DetailHotelBloc, DetailHotelState>(
                builder: (context, state) {
                  List<FavoriteHotel> favoriteHotel = state.favoriteHotel;
                  return Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 10,
                              child: Text(widget.arg.hotel.tenKS,
                                  style: tStyle.MediumBoldBlack()),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () => onTapBookmark(favoriteHotel),
                                  child: const Icon(Icons.bookmark,
                                      color: AppColors.red)),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColors.yellow,
                            ),
                            Text('5.0', style: tStyle.BaseRegularBlack())
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                            ),
                            Text(
                              widget.arg.hotel.diaChi,
                              style: tStyle.BaseRegularBlack(),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tiện nghi', style: tStyle.MediumBoldBlack()),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.lightPrimary),
                            child: Row(
                              children: [
                                const Icon(Icons.wifi),
                                const SizedBox(width: 8),
                                Text(
                                  'Free Wifi',
                                  style: tStyle.SmallRegular(),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Giờ nhận / trả phòng',
                        style: tStyle.MediumBoldBlack()),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text('Nhận phòng', style: tStyle.BaseRegularBlack())
                          ],
                        ),
                        Text('15:00 - 03:00', style: tStyle.BaseBoldBlack()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text('Trả phòng', style: tStyle.BaseRegularBlack())
                          ],
                        ),
                        Text('Trước 11:00', style: tStyle.BaseBoldBlack()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                color: AppColors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mô tả khách sạn',
                      style: tStyle.MediumBoldBlack(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Nằm dọc theo bãi biển Mỹ Khê cát trắng trải dài thơ mộng, khu nghỉ dưỡng dành cho gia đình sang trọng bật nhất thế giới Premier Village Danang được ưu ái tọa lạc ở vị trí đắc địa, hưởng trọn khung cảnh nên thơ của thành phố biển Đà Nẵng xinh đẹp. Với diện tích 1 quần đảo',
                      style: tStyle.BaseRegularBlack(),
                    )
                  ],
                ),
              ),
              Container(height: 150)
            ],
          ),

          //topbar
          const TopBarNoBackground(text: ''),
        ],
      ),
      bottomSheet: BottomSheetDefault(
        title: 'Giá phòng mỗi đêm',
        money: widget.arg.hotel.giaKS,
        textButton: 'Đặt phòng ngay',
        onTap: onTapCustomerInfo,
      ),
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapCustomerInfo() {
    if (context.read<DetailHotelBloc>().user != null) {
      Navigator.pushNamed(
        context,
        CustomerInfo.routeName,
        arguments: CustomerInfoArg(
          hotel: widget.arg.hotel,
          startDate: widget.arg.startDate,
          endDate: widget.arg.endDate,
          people: widget.arg.people,
          roomType: widget.arg.roomType,
          room: widget.arg.room,
          night: widget.arg.night,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return DialogPrimary(
            content: 'Bạn phải đăng nhập trước khi đặt phòng!',
            buttonText: 'Đồng ý',
            onTap: () {
              Navigator.pushNamed(context, LoginPage.routeName);
            },
          );
        },
      );
    }
  }

  void onTapBookmark(favoriteHotel) async {
    if (context.read<DetailHotelBloc>().user != null) {
      for (var element in favoriteHotel) {
        if (element.idKS == widget.arg.hotel.idKS) {
          showDialog(
            context: context,
            builder: (context) {
              return DialogPrimary(
                content: 'Khách sạn này đã được lưu!',
                buttonText: 'Đồng ý',
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
              );
            },
          );
        } else {
          await BookingRepo.saveFavoriteHotel(
            context.read<DetailHotelBloc>().user!.uid,
            widget.arg.hotel.idKS,
            widget.arg.hotel.tenKS,
            widget.arg.hotel.anhKS,
            widget.arg.hotel.giaKS,
            widget.arg.hotel.diaChi,
          );
          setState(() {});
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return DialogPrimary(
            content: 'Bạn phải đăng nhập trước khi lưu!',
            buttonText: 'Đồng ý',
            onTap: () {
              Navigator.pushNamed(context, LoginPage.routeName);
            },
          );
        },
      );
    }
  }
}
