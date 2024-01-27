// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/feature/home/bloc/home_bloc.dart';
import 'package:booking_admin/feature/home/bloc/home_event.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    getGreeting();
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

  DateTime dateTime = DateTime.now();
  String gretting = '';

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
                child: Text(gretting, style: tStyle.H1()),
              ),
              Container(
                padding: const EdgeInsets.only(left: 24),
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hotelList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
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
                                base64.decode(hotelList[index].anhKS),
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
                                      Text(hotelList[index].tenKS,
                                          style: tStyle.MediumBoldBlack()),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: AppColors.yellow,
                                          ),
                                          const SizedBox(width: 8),
                                          Text('5.0',
                                              style: tStyle.MediumBoldBlack()),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(hotelList[index].diaChi,
                                      style: tStyle.SmallRegular()),
                                  const SizedBox(height: 8),
                                  Text('\$${hotelList[index].giaKS}',
                                      style: tStyle.MediumBoldBlack()),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }
}
