// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:booking/feature/user/search/bloc/search_bloc.dart';
import 'package:booking/feature/user/search/bloc/search_event.dart';
import 'package:flutter/material.dart';
import 'package:booking/components/dialog/no_results.dart';
import 'package:booking/components/top_bar/topbar_default.dart';
import 'package:booking/components/top_bar/topbar_secondary.dart';
import 'package:booking/data/hotels.dart';
import 'package:booking/feature/user/detail_hotel/detail_hotel.dart';
import 'package:booking/source/colors.dart';
import 'package:booking/source/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/search_state.dart';

class SearchPageArg {
  final String nameLocation;
  final DateTime startDate;
  final DateTime endDate;
  final int people;
  final String roomType;
  final int room;
  final int night;
  final String locationCode;
  SearchPageArg({
    required this.nameLocation,
    required this.startDate,
    required this.endDate,
    required this.people,
    required this.roomType,
    required this.room,
    required this.night,
    required this.locationCode,
  });
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.arg});
  final SearchPageArg arg;
  static String routeName = 'search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(SearchGetHotelEvent(widget: widget));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchLoadingState) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primary,
                ));
              });
        }
        if (state is SearchDeleteLoadingState) {
          onTapBack();
        }
        if (state is SearchNoResultsState) {
          const NoResult();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            TopBarDefault(text: widget.arg.nameLocation, onTap: onTapBack),
            TopBarSecondary(
              startTime: widget.arg.startDate,
              night: widget.arg.night,
              room: widget.arg.roomType,
              people: widget.arg.people,
              onTap: onTapShowSearchBox,
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                List<Hotels> hotelList = state.listHotelByCondition;
                if (state.listHotelByCondition == []) {
                  return const NoResult();
                } else {
                  return Flexible(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 12),
                      shrinkWrap: true,
                      itemCount: hotelList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => onTapDetail(index, hotelList),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.white,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(
                                    base64.decode(hotelList[index].anhKS),
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(hotelList[index].tenKS,
                                          style: tStyle.BaseRegularBlack()),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: AppColors.yellow,
                                          ),
                                          const SizedBox(width: 5),
                                          Text('5',
                                              style: tStyle.BaseRegularBlack()),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Phòng ${hotelList[index].roomType}',
                                          style: tStyle.BaseRegularBlack()),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text('${hotelList[index].giaKS} đ',
                                              style: tStyle.BaseBoldPrimary()),
                                          Text(' / phòng / đêm',
                                              style: tStyle.SmallRegular())
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapDetail(index, hotelList) {
    Navigator.pushNamed(context, DetailHotelPage.routeName,
        arguments: DetailHotelArg(
          hotel: hotelList[index],
          startDate: widget.arg.startDate,
          endDate: widget.arg.endDate,
          people: widget.arg.people,
          roomType: widget.arg.roomType,
          room: widget.arg.room,
          night: widget.arg.night,
        ));
  }

  void onTapShowSearchBox() {
    // Navigator.pushNamed(context, routeName)
  }
}
