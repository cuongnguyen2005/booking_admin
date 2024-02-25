import 'package:booking_admin/components/top_bar/topbar_third.dart';
import 'package:booking_admin/data/notification.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:flutter/material.dart';

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
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: notifiList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Text('Bạn có đơn mới từ được dặt vào ngày ${notifiList[index].dateTime}'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
