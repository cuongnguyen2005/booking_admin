import 'package:booking_admin/components/top_bar/topbar_second.dart';
import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/feature/calendar/bloc/calendar_bloc.dart';
import 'package:booking_admin/feature/calendar/bloc/calendar_event.dart';
import 'package:booking_admin/feature/detail_payment.dart';
import 'package:booking_admin/feature/seach_booking.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/number_format.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'bloc/calendar_state.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  void initState() {
    super.initState();
    getBookingList();
  }

  void getBookingList() {
    context.read<CalendarBloc>().add(CalendarGetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarSecond(
            text: 'Lịch trình của bạn',
            onTap: onTapSearch,
          ),
          Container(
            color: AppColors.white,
            child: TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              rowHeight: 40,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              focusedDay: context.read<CalendarBloc>().today,
              firstDay: DateTime.utc(2000),
              lastDay: DateTime.utc(2050),
              onPageChanged: (focusedDay) {
                context.read<CalendarBloc>().today = focusedDay;
                getBookingList();
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              List<Booking> bookingList = state.listBooking;
              return Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: bookingList.length,
                  itemBuilder: (context, index) {
                    List<String> statusList = [];
                    for (var element in bookingList) {
                      if (element.trangThai == 2) {
                        context.read<CalendarBloc>().status = 'Đang xử lý';
                      } else if (element.trangThai == 1) {
                        context.read<CalendarBloc>().status = ' Đã từ chối';
                      } else if (element.trangThai == 0) {
                        context.read<CalendarBloc>().status = 'Thành công';
                      }
                      statusList.add(context.read<CalendarBloc>().status);
                    }
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, top: 12, bottom: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${bookingList[index].ngayNhan.day}/${bookingList[index].ngayNhan.month}/${bookingList[index].ngayNhan.year}',
                            style: tStyle.MediumBoldBlack(),
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () => onTapDetailPayment(index, bookingList),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: bookingList[index].trangThai == 2
                                          ? AppColors.yellow.withOpacity(0.2)
                                          : bookingList[index].trangThai == 1
                                              ? AppColors.red.withOpacity(0.2)
                                              : AppColors.green
                                                  .withOpacity(0.2),
                                    ),
                                    child: Text(statusList[index],
                                        style: bookingList[index].trangThai == 2
                                            ? tStyle.BaseRegularYellow()
                                            : bookingList[index].trangThai == 1
                                                ? tStyle.BaseRegularRed()
                                                : tStyle.BaseRegularGreen()),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: AppColors.lightGrey),
                                    )),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.home),
                                        const SizedBox(width: 10),
                                        Text(bookingList[index].tenKS,
                                            style: tStyle.BaseBoldBlack()),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 12),
                                    width: double.infinity,
                                    child: Text(
                                      '${NumberFormatUnity.priceFormat(bookingList[index].thanhTien)} đ',
                                      style: tStyle.BaseBoldPrimary(),
                                      textAlign: TextAlign.end,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void onTapDetailPayment(index, bookingList) {
    Navigator.pushNamed(context, DetailPayment.routeName,
            arguments: bookingList[index])
        .then((value) => getBookingList());
  }

  void onTapSearch() {
    Navigator.pushNamed(context, SearchBookingPage.routeName);
  }
}
