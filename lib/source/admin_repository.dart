import 'package:booking_admin/data/admin_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRepository {
  static Future<AdminAccount> getAdminDetail(String uid)async{
    final snapshot = await FirebaseFirestore.instance.collection('users').where("uid", isEqualTo: uid).get();
    final adminData = snapshot.docs.map((e) => AdminAccount.fromMap(e)).single;
    return adminData;
  }
}