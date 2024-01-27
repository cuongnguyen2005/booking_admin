// ignore_for_file: public_member_api_docs, sort_constructors_first
class Locations {
  String id;
  String name;
  String locationCode;
  Locations({
    required this.id,
    required this.name,
    required this.locationCode,
  });
}

List<Locations> location = [
  Locations(id: '1', name: 'Hà Nội', locationCode: 'hanoi'),
  Locations(id: '2', name: 'Đà Nẵng', locationCode: 'danang'),
  Locations(id: '3', name: 'Nha Trang', locationCode: 'nhatrang'),
  Locations(id: '4', name: 'Hội An', locationCode: 'hoian'),
  Locations(id: '5', name: 'Vinh', locationCode: 'vinh'),
  Locations(id: '6', name: 'Hồ chí Minh', locationCode: 'hochiminh'),
];
