import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationClass {
  String idNoti;
  String tenKS;
  DateTime dateTime;
  DateTime dateCheckIn;
  NotificationClass({
    required this.idNoti,
    required this.tenKS,
    required this.dateTime,
    required this.dateCheckIn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idNoti': idNoti,
      'tenKS': tenKS,
      'dateTime': dateTime.toIso8601String(),
      'dateCheckIn': dateCheckIn.toIso8601String(),
    };
  }

  factory NotificationClass.fromMap(Map<String, dynamic> map) {
    return NotificationClass(
      idNoti: map['idNoti'] as String,
      tenKS: map['tenKS'] as String,
      dateTime: DateTime.parse(map['dateTime']),
      dateCheckIn: DateTime.parse(map['dateCheckIn']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationClass.fromJson(String source) => NotificationClass.fromMap(json.decode(source) as Map<String, dynamic>);
}
