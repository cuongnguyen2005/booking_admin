import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Hotels {
  String idKS;
  String tenKS;
  String diaChi;
  String thanhPho;
  String maDiaDiem;
  int giaKS;
  String anhKS;
  String maKS;
  String moTa;
  String codeTenKS;
  Hotels({
    required this.idKS,
    required this.tenKS,
    required this.diaChi,
    required this.thanhPho,
    required this.maDiaDiem,
    required this.giaKS,
    required this.anhKS,
    required this.maKS,
    required this.moTa,
    required this.codeTenKS,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idKS': idKS,
      'tenKS': tenKS,
      'diaChi': diaChi,
      'thanhPho': thanhPho,
      'maDiaDiem': maDiaDiem,
      'gia': giaKS,
      'anhKS': anhKS,
      'maKS': maKS,
      'moTa': moTa,
      'codeTenKS': codeTenKS,
    };
  }

  factory Hotels.fromMap(Map<String, dynamic> map) {
    return Hotels(
      idKS: map['idKS'] as String,
      tenKS: map['tenKS'] as String,
      diaChi: map['diaChi'] as String,
      thanhPho: map['thanhPho'] as String,
      maDiaDiem: map['maDiaDiem'] as String,
      giaKS: map['gia'] as int,
      anhKS: map['anhKS'] as String,
      maKS: map['maKS'] as String,
      moTa: map['moTa'] as String,
      codeTenKS: map['codeTenKS'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hotels.fromJson(String source) =>
      Hotels.fromMap(json.decode(source) as Map<String, dynamic>);
}
