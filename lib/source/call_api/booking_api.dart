import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/data/notification.dart';
import 'package:booking_admin/data/rooms.dart';
import 'package:dio/dio.dart';

class BookingRepo {
  //lấy dữ liệu khách sạn
  static Future<List<Hotels>> getHotels() async {
    final dio = Dio();
    final Response response = await dio
        .get('https://booking-9cf26-default-rtdb.firebaseio.com/Hotels.json');
    if (response.data != null) {
      Map<String, dynamic> json = response.data;
      final List<Hotels> hotelList =
          json.values.map((e) => Hotels.fromMap(e)).toList();
      return hotelList;
    } else {
      return [];
    }
  }

  //thêm khách sạn
  static Future<List<Hotels>> addHotels(
    String tenKS,
    String diaChi,
    String thanhPho,
    String maDiaDiem,
    int gia,
    String anhKS,
    String maKS,
    String moTa,
    String codeTenKS,
  ) async {
    final dio = Dio();
    String url =
        'https://booking-9cf26-default-rtdb.firebaseio.com/Hotels.json';
    Hotels hotel = Hotels(
      idKS: '',
      tenKS: tenKS,
      diaChi: diaChi,
      thanhPho: thanhPho,
      maDiaDiem: maDiaDiem,
      giaKS: gia,
      anhKS: anhKS,
      maKS: maKS,
      moTa: moTa,
      codeTenKS: codeTenKS,
    );
    final Response response = await dio.post(url, data: hotel.toMap());
    if (response.data != null) {
      String id = response.data['name'];
      String url1 =
          'https://booking-9cf26-default-rtdb.firebaseio.com/Hotels/$id.json';
      await dio.patch(url1, data: {'idKS': id});
    }
    return [];
  }

  //edit khach san
  static Future<List<Hotels>> editHotels(
    String key,
    String tenKS,
    String diaChi,
    String thanhPho,
    String maDiaDiem,
    int gia,
    String anhKS,
    String maKS,
    String moTa,
    String codeTenKS,
  ) async {
    final dio = Dio();
    String url =
        'https://booking-9cf26-default-rtdb.firebaseio.com/Hotels/$key.json';
    Hotels hotel = Hotels(
      idKS: key,
      tenKS: tenKS,
      diaChi: diaChi,
      thanhPho: thanhPho,
      maDiaDiem: maDiaDiem,
      giaKS: gia,
      anhKS: anhKS,
      maKS: maKS,
      moTa: moTa,
      codeTenKS: codeTenKS,
    );
    dio.patch(url, data: hotel.toMap());
    return [];
  }

  //delete hotel
  static Future<List<Hotels>> deleteHotel(String key) async {
    final dio = Dio();
    await dio.delete(
        'https://booking-9cf26-default-rtdb.firebaseio.com/Hotels/$key.json');
    return [];
  }

  //thêm phòng
  static Future<List<Rooms>> addRooms(
      String tenPhong,
      String thanhPho,
      int giaPhong,
      String kieuPhong,
      String anhPhong,
      String idKS,
      String maKS) async {
    final dio = Dio();
    String url = 'https://booking-9cf26-default-rtdb.firebaseio.com/Rooms.json';
    Rooms room = Rooms(
      idPhong: '',
      tenPhong: tenPhong,
      thanhPho: thanhPho,
      giaPhong: giaPhong,
      kieuPhong: kieuPhong,
      anhPhong: anhPhong,
      idKS: idKS,
      maKS: maKS,
    );
    final Response response = await dio.post(url, data: room.toMap());
    if (response.data != null) {
      String id = response.data['name'];
      String url1 =
          'https://booking-9cf26-default-rtdb.firebaseio.com/Rooms/$id.json';
      await dio.patch(url1, data: {'idPhong': id});
    }
    return [];
  }

  //edit phòng
  static Future<List<Rooms>> editRooms(
      String key,
      String tenPhong,
      String thanhPho,
      int giaPhong,
      String kieuPhong,
      String anhPhong,
      String idKS,
      String maKS) async {
    final dio = Dio();
    String url =
        'https://booking-9cf26-default-rtdb.firebaseio.com/Rooms/$key.json';
    Rooms room = Rooms(
      idPhong: key,
      tenPhong: tenPhong,
      thanhPho: thanhPho,
      giaPhong: giaPhong,
      kieuPhong: kieuPhong,
      anhPhong: anhPhong,
      idKS: idKS,
      maKS: maKS,
    );
    await dio.patch(url, data: room.toMap());

    return [];
  }

  //lấy dữ liệu phong
  static Future<List<Rooms>> getRooms() async {
    final dio = Dio();
    final Response response = await dio
        .get('https://booking-9cf26-default-rtdb.firebaseio.com/Rooms.json');
    if (response.data != null) {
      Map<String, dynamic> json = response.data;
      final List<Rooms> roomslList =
          json.values.map((e) => Rooms.fromMap(e)).toList();
      return roomslList;
    } else {
      return [];
    }
  }

  //delete phong
  static Future<List<Rooms>> deleteRooms(String key) async {
    final dio = Dio();
    await dio.delete(
        'https://booking-9cf26-default-rtdb.firebaseio.com/Rooms/$key.json');
    return [];
  }

  //get booking by User
  static Future<List<Booking>> getBookingByUser() async {
    final dio = Dio();
    final Response response = await dio.get(
        'https://booking-9cf26-default-rtdb.firebaseio.com/TotalBookingHotel.json');

    if (response.data != null) {
      Map<String, dynamic> json = response.data;
      final List<Booking> bookingList =
          json.values.map((e) => Booking.fromMap(e)).toList();
      return bookingList;
    } else {
      return [];
    }
  }

  //Xu ly don dat phong
  static Future<List<Booking>> editBooking(
    String key,
    String idUser,
    String hoTen,
    String email,
    String sdt,
    DateTime ngayNhan,
    DateTime ngayTra,
    int soDem,
    int soNguoi,
    int soPhong,
    int thanhTien,
    String tenKS,
    String tenPhong,
    int giaKS,
    String kieuPhong,
    String maKS,
    int trangThai,
  ) async {
    final dio = Dio();
    String url =
        'https://booking-9cf26-default-rtdb.firebaseio.com/TotalBookingHotel/$key.json';
    Booking bookingHotel = Booking(
      idBooking: key,
      idUser: idUser,
      hoTen: hoTen,
      email: email,
      sdt: sdt,
      ngayNhan: ngayNhan,
      ngayTra: ngayTra,
      soDem: soDem,
      soNguoi: soNguoi,
      soPhong: soPhong,
      thanhTien: thanhTien,
      tenKS: tenKS,
      tenPhong: tenPhong,
      giaKS: giaKS,
      kieuPhong: kieuPhong,
      maKS: maKS,
      trangThai: trangThai,
    );
    await dio.patch(url, data: bookingHotel.toMap());
    return [];
  }

  //get notification
  static Future<List<NotificationClass>> getNotifi() async {
    final dio = Dio();
    final Response response = await dio.get(
        'https://booking-9cf26-default-rtdb.firebaseio.com/Notifications.json');
    if (response.data != null) {
      Map<String, dynamic> json = response.data;
      final List<NotificationClass> notifiList =
          json.values.map((e) => NotificationClass.fromMap(e)).toList();
      return notifiList;
    } else {
      return [];
    }
  }
}
