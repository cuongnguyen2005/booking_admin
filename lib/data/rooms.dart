import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Rooms {
  String idPhong;
  String tenPhong;
  String thanhPho;
  int giaPhong;
  String kieuPhong;
  String anhPhong;
  String idKS;
  String maKS;
  Rooms({
    required this.idPhong,
    required this.tenPhong,
    required this.thanhPho,
    required this.giaPhong,
    required this.kieuPhong,
    required this.anhPhong,
    required this.idKS,
    required this.maKS,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPhong': idPhong,
      'tenPhong': tenPhong,
      'thanhPho': thanhPho,
      'gia': giaPhong,
      'kieuPhong': kieuPhong,
      'anhKS': anhPhong,
      'idKS': idKS,
      'maKS': maKS,
    };
  }

  factory Rooms.fromMap(Map<String, dynamic> map) {
    return Rooms(
      idPhong: map['idPhong'] as String,
      tenPhong: map['tenPhong'] as String,
      thanhPho: map['thanhPho'] as String,
      giaPhong: map['gia'] as int,
      kieuPhong: map['kieuPhong'] as String,
      anhPhong: map['anhKS'] as String,
      idKS: map['idKS'] as String,
      maKS: map['maKS'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rooms.fromJson(String source) =>
      Rooms.fromMap(json.decode(source) as Map<String, dynamic>);
}
