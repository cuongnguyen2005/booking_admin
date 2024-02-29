import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Hotels {
  String idKS;
  String tenKS;
  String diaChi;
  String thanhPho;
  int giaKS;
  String anhKS;
  String moTa;
  String maKS;
  Hotels({
    required this.idKS,
    required this.tenKS,
    required this.diaChi,
    required this.thanhPho,
    required this.giaKS,
    required this.anhKS,
    required this.moTa,
    required this.maKS,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idKS': idKS,
      'tenKS': tenKS,
      'diaChi': diaChi,
      'thanhPho': thanhPho,
      'giaKS': giaKS,
      'anhKS': anhKS,
      'moTa': moTa,
      'maKS': maKS,
    };
  }

  factory Hotels.fromMap(Map<String, dynamic> map) {
    return Hotels(
      idKS: map['idKS'] as String,
      tenKS: map['tenKS'] as String,
      diaChi: map['diaChi'] as String,
      thanhPho: map['thanhPho'] as String,
      giaKS: map['giaKS'] as int,
      anhKS: map['anhKS'] as String,
      moTa: map['moTa'] as String,
      maKS: map['maKS'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hotels.fromJson(String source) =>
      Hotels.fromMap(json.decode(source) as Map<String, dynamic>);
}
