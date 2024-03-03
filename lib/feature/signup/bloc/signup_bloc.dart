import 'package:booking_admin/data/admin_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumbereController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController maCtyController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();
  final TextEditingController cmndController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  SignupBloc() : super(SignupInitial()) {
    on<SignupVisibilityEvent>((event, emit) {
      emit(SignupState(visibility: !state.visibility));
    });
    on<SignupSubmitEvent>((event, emit) async {
      try {
        final UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: usernameController.text, password: pwController.text);
        if (user.user?.uid != null) {
          AdminAccount userAccount = AdminAccount(
            hoTen: nameController.text,
            ngaySinh: DateTime.now(),
            diaChi: diaChiController.text,
            cmnd: int.parse(cmndController.text),
            sdt: phoneNumbereController.text,
            gioiTinh: '',
            avatar: '',
            email: usernameController.text,
            maKS: maCtyController.text,
          );
          await FirebaseFirestore.instance
              .collection('admins')
              .doc(user.user!.uid)
              .set(userAccount.toMap());
          emit(SignupSuccessState());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          emit(SignupErrorUserState());
        }
        if (e.code == 'network-request-failed') {
          emit(SignupErrorNetworkState());
        }
      } catch (e) {
        //some error
      }
    });
  }
}
