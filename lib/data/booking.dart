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
  String idKS;
  String tenKS;
  int giaKS;
  String roomType;
  String congTy;
  String maCongTy;
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
    required this.idKS,
    required this.tenKS,
    required this.giaKS,
    required this.roomType,
    required this.congTy,
    required this.maCongTy,
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
      'idKS': idKS,
      'tenKS': tenKS,
      'giaPhong': giaKS,
      'roomType': roomType,
      'congTy': congTy,
      'maCongTy': maCongTy,
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
      idKS: map['idKS'] as String,
      tenKS: map['tenKS'] as String,
      giaKS: map['giaPhong'] as int,
      roomType: map['roomType'] as String,
      congTy: map['congTy'] as String,
      maCongTy: map['maCongTy'] as String,
      trangThai: map['trangThai'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
