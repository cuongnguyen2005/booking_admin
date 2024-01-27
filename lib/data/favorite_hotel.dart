import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FavoriteHotel {
  String id;
  String idKS;
  String tenKS;
  String anhKS;
  int giaKS;
  String diaChi;
  FavoriteHotel({
    required this.id,
    required this.idKS,
    required this.tenKS,
    required this.anhKS,
    required this.giaKS,
    required this.diaChi,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idKS': idKS,
      'tenKS': tenKS,
      'anhKS': anhKS,
      'gia': giaKS,
      'diaChi': diaChi,
    };
  }

  factory FavoriteHotel.fromMap(Map<String, dynamic> map) {
    return FavoriteHotel(
      id: map['id'] as String,
      idKS: map['idKS'] as String,
      tenKS: map['tenKS'] as String,
      anhKS: map['anhKS'] as String,
      giaKS: map['gia'] as int,
      diaChi: map['diaChi'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteHotel.fromJson(String source) =>
      FavoriteHotel.fromMap(json.decode(source) as Map<String, dynamic>);
}
