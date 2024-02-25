import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Booking {
  String idBooking;
  String idUser;
  String hoTen;
  String email;
  String sdt;
  DateTime ngayNhan;
  DateTime ngayTra;
  int soDem;
  int soNguoi;
  int soPhong;
  int thanhTien;
  String tenKS;
  String tenPhong;
  int giaKS;
  String kieuPhong;
  String maKS;
  int trangThai;
  Booking({
    required this.idBooking,
    required this.idUser,
    required this.hoTen,
    required this.email,
    required this.sdt,
    required this.ngayNhan,
    required this.ngayTra,
    required this.soDem,
    required this.soNguoi,
    required this.soPhong,
    required this.thanhTien,
    required this.tenKS,
    required this.tenPhong,
    required this.giaKS,
    required this.kieuPhong,
    required this.maKS,
    required this.trangThai,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idBooking': idBooking,
      'idUser': idUser,
      'hoTen': hoTen,
      'email': email,
      'sdt': sdt,
      'ngayNhan': ngayNhan.toIso8601String(),
      'ngayTra': ngayTra.toIso8601String(),
      'soDem': soDem,
      'soNguoi': soNguoi,
      'soPhong': soPhong,
      'thanhTien': thanhTien,
      'idKS': tenKS,
      'tenKS': tenPhong,
      'giaPhong': giaKS,
      'kieuPhong': kieuPhong,
      'maKS': maKS,
      'trangThai': trangThai,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      idBooking: map['idBooking'] as String,
      idUser: map['idUser'] as String,
      hoTen: map['hoTen'] as String,
      email: map['email'] as String,
      sdt: map['sdt'] as String,
      ngayNhan: DateTime.parse(map['ngayNhan']),
      ngayTra: DateTime.parse(map['ngayTra']),
      soDem: map['soDem'] as int,
      soNguoi: map['soNguoi'] as int,
      soPhong: map['soPhong'] as int,
      thanhTien: map['thanhTien'] as int,
      tenKS: map['idKS'] as String,
      tenPhong: map['tenKS'] as String,
      giaKS: map['giaPhong'] as int,
      kieuPhong: map['kieuPhong'] as String,
      maKS: map['maKS'] as String,
      trangThai: map['trangThai'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
