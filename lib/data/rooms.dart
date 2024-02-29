import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Rooms {
  String idPhong;
  String tenPhong;
  int giaPhong;
  String loaiGiuong;
  int soLuongGiuong;
  String anhPhong;
  int soLuongNguoi;
  int dienTichPhong;
  String idKS;
  Rooms({
    required this.idPhong,
    required this.tenPhong,
    required this.giaPhong,
    required this.loaiGiuong,
    required this.soLuongGiuong,
    required this.anhPhong,
    required this.soLuongNguoi,
    required this.dienTichPhong,
    required this.idKS,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPhong': idPhong,
      'tenPhong': tenPhong,
      'giaPhong': giaPhong,
      'loaiGiuong': loaiGiuong,
      'soLuongGiuong': soLuongGiuong,
      'anhPhong': anhPhong,
      'soLuongNguoi': soLuongNguoi,
      'dienTichPhong': dienTichPhong,
      'idKS': idKS,
    };
  }

  factory Rooms.fromMap(Map<String, dynamic> map) {
    return Rooms(
      idPhong: map['idPhong'] as String,
      tenPhong: map['tenPhong'] as String,
      giaPhong: map['giaPhong'] as int,
      loaiGiuong: map['loaiGiuong'] as String,
      soLuongGiuong: map['soLuongGiuong'] as int,
      anhPhong: map['anhPhong'] as String,
      soLuongNguoi: map['soLuongNguoi'] as int,
      dienTichPhong: map['dienTichPhong'] as int,
      idKS: map['idKS'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rooms.fromJson(String source) =>
      Rooms.fromMap(json.decode(source) as Map<String, dynamic>);
}
