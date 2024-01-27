// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:booking_admin/components/box/search_box_primary.dart';
import 'package:booking_admin/components/box/search_box_secondary.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/source/colors.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key? key,
    required this.contentNameLocation,
    required this.contentDateTimeCheck,
    required this.night,
    required this.contentSelectPersonAndRoomType,
    this.onTapShowLocation,
    this.onTapShowRangeTime,
    this.onTapSelectPeople,
    this.onTapSearch,
  }) : super(key: key);
  final String contentNameLocation;
  final String contentDateTimeCheck;
  final int night;
  final String contentSelectPersonAndRoomType;
  final void Function()? onTapShowLocation;
  final void Function()? onTapShowRangeTime;
  final void Function()? onTapSelectPeople;
  final void Function()? onTapSearch;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          SearchBoxPrimary(
            title: 'Điểm đến',
            content: widget.contentNameLocation,
            icon: Icons.location_on,
            onTap: widget.onTapShowLocation,
          ),
          const SizedBox(height: 10),
          SearchBoxSecondary(
            title: 'Ngày nhận - trả phòng',
            content: widget.contentDateTimeCheck,
            icon: Icons.calendar_month,
            night: widget.night,
            onTap: widget.onTapShowRangeTime,
          ),
          const SizedBox(height: 10),
          SearchBoxPrimary(
            title: 'Loại phòng và khách',
            content: widget.contentSelectPersonAndRoomType,
            icon: Icons.person_add,
            onTap: widget.onTapSelectPeople,
          ),
          const SizedBox(height: 10),
          ButtonPrimary(
            text: 'Tìm kiếm',
            onTap: widget.onTapSearch,
          ),
        ],
      ),
    );
  }
}
