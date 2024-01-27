import 'package:booking_admin/data/booking.dart';
import 'package:booking_admin/data/favorite_hotel.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:dio/dio.dart';

class BookingRepo {
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

  static Future<List<Hotels>> addHotels(
    String tenKS,
    String diaChi,
    String thanhPho,
    String maDiaDiem,
    int gia,
    String anhKS,
    String roomType,
    String congTy,
    String maCongTy,
    String maNV,
    String moTa,
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
      roomType: roomType,
      congTy: congTy,
      maCongTy: maCongTy,
      maNV: maNV,
      moTa: moTa,
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

  //save booking
  static Future<List<Booking>> bookingHotel(
    String uid,
    String hoTen,
    String email,
    String sdt,
    DateTime ngayNhan,
    DateTime ngayTra,
    int soDem,
    int soNguoi,
    int soPhong,
    int thanhTien,
    String idKS,
    String tenKS,
    int giaPhong,
    String roomType,
    String congTy,
    String maCongTy,
  ) async {
    final dio = Dio();
    String url =
        'https://booking-9cf26-default-rtdb.firebaseio.com/TotalBookingHotel.json';
    Booking bookingHotel = Booking(
      idBooking: '',
      idUser: uid,
      hoTen: hoTen,
      email: email,
      sdt: sdt,
      ngayNhan: ngayNhan,
      ngayTra: ngayTra,
      soDem: soDem,
      soNguoi: soNguoi,
      soPhong: soPhong,
      thanhTien: thanhTien,
      idKS: idKS,
      tenKS: tenKS,
      giaKS: giaPhong,
      roomType: roomType,
      congTy: congTy,
      maCongTy: maCongTy,
      trangThai: 2, // 2: chờ xử lý, 1: từ chối, 0: hoàn thành
    );
    final Response response = await dio.post(url, data: bookingHotel.toMap());
    if (response.data != null) {
      String id = response.data['name'];
      String url1 =
          'https://booking-9cf26-default-rtdb.firebaseio.com/TotalBookingHotel/$id.json';
      await dio.patch(url1, data: {'idBooking': id});
    }
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

  //save favorite hotel by user
  static Future<List<FavoriteHotel>> saveFavoriteHotel(
    String uid,
    String idKS,
    String tenKS,
    String anhKS,
    int gia,
    String diaChi,
  ) async {
    final dio = Dio();
    String url =
        'https://booking-9cf26-default-rtdb.firebaseio.com/FavoriteHotelByUser/$uid.json';
    FavoriteHotel favoriteHotel = FavoriteHotel(
      id: '',
      idKS: idKS,
      tenKS: tenKS,
      anhKS: anhKS,
      giaKS: gia,
      diaChi: diaChi,
    );
    final Response response = await dio.post(url, data: favoriteHotel.toMap());
    if (response.data != null) {
      String id = response.data['name'];
      String url1 =
          'https://booking-9cf26-default-rtdb.firebaseio.com/FavoriteHotelByUser/$uid/$id.json';
      await dio.patch(url1, data: {'id': id});
    }
    return [];
  }

  //get favorite hotel by user
  static Future<List<FavoriteHotel>> getFavoriteHotelByUser(String uid) async {
    final dio = Dio();
    final Response response = await dio.get(
        'https://booking-9cf26-default-rtdb.firebaseio.com/FavoriteHotelByUser/$uid.json');

    if (response.data != null) {
      Map<String, dynamic> json = response.data;
      final List<FavoriteHotel> favoriteHotel =
          json.values.map((e) => FavoriteHotel.fromMap(e)).toList();
      return favoriteHotel;
    } else {
      return [];
    }
  }
}
