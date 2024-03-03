import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdminAccount {
  String hoTen;
  DateTime ngaySinh;
  String diaChi;
  int cmnd;
  String sdt;
  String gioiTinh;
  String avatar;
  String email;
  String maKS;
  AdminAccount({
    required this.hoTen,
    required this.ngaySinh,
    required this.diaChi,
    required this.cmnd,
    required this.sdt,
    required this.gioiTinh,
    required this.avatar,
    required this.email,
    required this.maKS,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hoTen': hoTen,
      'ngaySinh': ngaySinh.toIso8601String(),
      'diaChi': diaChi,
      'cmnd': cmnd,
      'sdt': sdt,
      'gioiTinh': gioiTinh,
      'avatar': avatar,
      'email': email,
      'maKS': maKS,
    };
  }

  factory AdminAccount.fromMap(map) {
    return AdminAccount(
      hoTen: map['hoTen'] as String,
      ngaySinh: DateTime.parse(map['ngaySinh']),
      diaChi: map['diaChi'] as String,
      cmnd: map['cmnd'] as int,
      sdt: map['sdt'] as String,
      gioiTinh: map['gioiTinh'] as String,
      avatar: map['avatar'] as String,
      email: map['email'] as String,
      maKS: map['maKS'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminAccount.fromJson(String source) =>
      AdminAccount.fromMap(json.decode(source) as Map<String, dynamic>);
}
