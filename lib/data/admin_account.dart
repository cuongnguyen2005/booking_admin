import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdminAccount {
  String hoTen;
  String gioiTinh;
  String diaChi;
  String avatar;
  String email;
  String sdt;
  String maCty;
  AdminAccount({
    required this.hoTen,
    required this.gioiTinh,
    required this.diaChi,
    required this.avatar,
    required this.email,
    required this.sdt,
    required this.maCty,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hoTen': hoTen,
      'gioiTinh': gioiTinh,
      'diaChi': diaChi,
      'avatar': avatar,
      'email': email,
      'sdt': sdt,
      'maCty': maCty,
    };
  }

  factory AdminAccount.fromMap(map) {
    return AdminAccount(
      hoTen: map['hoTen'] as String,
      gioiTinh: map['gioiTinh'] as String,
      diaChi: map['diaChi'] as String,
      avatar: map['avatar'] as String,
      email: map['email'] as String,
      sdt: map['sdt'] as String,
      maCty: map['maCty'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminAccount.fromJson(String source) =>
      AdminAccount.fromMap(json.decode(source) as Map<String, dynamic>);
}
