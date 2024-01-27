import 'dart:convert';
import 'dart:typed_data';

import 'package:booking/data/user_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumbereController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
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
          ByteData bytes =
              await rootBundle.load('assets/images/avatar_white.jpg');
          final ByteBuffer buffer = bytes.buffer;
          UserAccount userAccount = UserAccount(
            hoTen: nameController.text,
            gioiTinh: '',
            diaChi: '',
            avatar: base64.encode(Uint8List.view(buffer)),
            email: usernameController.text,
            sdt: phoneNumbereController.text,
            idCongty: '',
            quyenAdmin: 0,
            quyenUser: 1,
          );
          await FirebaseFirestore.instance
              .collection('users')
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
      } catch (e) {}
    });
  }
}
