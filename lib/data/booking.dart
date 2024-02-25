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
  String maKS;
  String tenKS;
  int giaPhong;
  String roomType;
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
    required this.maKS,
    required this.tenKS,
    required this.giaPhong,
    required this.roomType,
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
      'maKS': maKS,
      'tenKS': tenKS,
      'giaPhong': giaPhong,
      'roomType': roomType,
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
      maKS: map['maKS'] as String,
      tenKS: map['tenKS'] as String,
      giaPhong: map['giaPhong'] as int,
      roomType: map['roomType'] as String,
      trangThai: map['trangThai'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
