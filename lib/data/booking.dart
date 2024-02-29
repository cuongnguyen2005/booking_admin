import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Booking {
  String idDatPhong;
  DateTime ngayNhan;
  DateTime ngayTra;
  int soDem;
  int soLuongNguoi;
  int soLuongPhong;
  int thanhTien;
  String hoTen;
  String email;
  String sdt;
  int dienTichPhong;
  String tenPhong;
  int giaPhong;
  String loaiGiuong;
  String maKS;
  String tenKS;
  String idKhachHang;
  int trangThai;
  Booking({
    required this.idDatPhong,
    required this.ngayNhan,
    required this.ngayTra,
    required this.soDem,
    required this.soLuongNguoi,
    required this.soLuongPhong,
    required this.thanhTien,
    required this.hoTen,
    required this.email,
    required this.sdt,
    required this.dienTichPhong,
    required this.tenPhong,
    required this.giaPhong,
    required this.loaiGiuong,
    required this.maKS,
    required this.tenKS,
    required this.idKhachHang,
    required this.trangThai,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idDatPhong': idDatPhong,
      'ngayNhan': ngayNhan.toIso8601String(),
      'ngayTra': ngayTra.toIso8601String(),
      'soDem': soDem,
      'soLuongNguoi': soLuongNguoi,
      'soLuongPhong': soLuongPhong,
      'thanhTien': thanhTien,
      'hoTen': hoTen,
      'email': email,
      'sdt': sdt,
      'dienTichPhong': dienTichPhong,
      'tenPhong': tenPhong,
      'giaPhong': giaPhong,
      'loaiGiuong': loaiGiuong,
      'maKS': maKS,
      'tenKS': tenKS,
      'idKhachHang': idKhachHang,
      'trangThai': trangThai,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      idDatPhong: map['idDatPhong'] as String,
      ngayNhan: DateTime.parse(map['ngayNhan']),
      ngayTra: DateTime.parse(map['ngayTra']),
      soDem: map['soDem'] as int,
      soLuongNguoi: map['soLuongNguoi'] as int,
      soLuongPhong: map['soLuongPhong'] as int,
      thanhTien: map['thanhTien'] as int,
      hoTen: map['hoTen'] as String,
      email: map['email'] as String,
      sdt: map['sdt'] as String,
      dienTichPhong: map['dienTichPhong'] as int,
      tenPhong: map['tenPhong'] as String,
      giaPhong: map['giaPhong'] as int,
      loaiGiuong: map['loaiGiuong'] as String,
      maKS: map['maKS'] as String,
      tenKS: map['tenKS'] as String,
      idKhachHang: map['idKhachHang'] as String,
      trangThai: map['trangThai'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
