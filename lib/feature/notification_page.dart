import 'package:booking_admin/components/top_bar/topbar_third.dart';
import 'package:booking_admin/data/notification.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    getNotifi();
  }

  List<NotificationClass> notifiList = [];
  void getNotifi() async {
    List<NotificationClass> notifiListAPI = await BookingRepo.getNotifi();
    setState(() {
      notifiList = notifiListAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopBarThird(text: 'Thông báo'),
          const SizedBox(height: 10),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: notifiList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications, color: AppColors.red),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Bạn có đơn mới từ được đặt vào ngày ${DateFormat.yMd().format(notifiList[index].dateTime)}',
                            style: tStyle.MediumBoldBlack(),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                ' ${DateFormat.jm().format(notifiList[index].dateTime)}',
                                style: tStyle.MediumRegularBlack(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
