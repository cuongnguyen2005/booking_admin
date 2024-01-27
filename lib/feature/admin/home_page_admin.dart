import 'dart:convert';

import 'package:booking_admin/components/top_bar/topbar_third.dart';
import 'package:booking_admin/data/hotels.dart';
import 'package:booking_admin/data/user_account.dart';
import 'package:booking_admin/feature/admin/add_hotel.dart';
import 'package:booking_admin/source/call_api/booking_api.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  @override
  void initState() {
    super.initState();
    getListHotels();
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserAccount? usersAccount;
  List<Hotels> listHotel = [];
  void getListHotels() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((value) {
      setState(() {
        usersAccount = UserAccount.fromMap(value.data());
      });
    });
    List<Hotels> listFromDatabase = await BookingRepo.getHotels();
    for (var element in listFromDatabase) {
      if (element.maCongTy == usersAccount!.idCongty) {
        setState(() {
          listHotel.add(element);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopBarThird(text: 'Danh sách khách sạn'),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: listHotel.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onTapEdit(index),
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            base64.decode(listHotel[index].anhKS),
                            height: 100,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listHotel[index].tenKS),
                            const SizedBox(height: 8),
                            Text('${listHotel[index].giaKS} đ'),
                            const SizedBox(height: 8),
                            Text('Phòng ${listHotel[index].roomType}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void onTapEdit(index) {
    Navigator.pushNamed(context, AddHotel.routeName,
        arguments: listHotel[index]);
  }
}
