import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  LoginBloc() : super(LoginInitial()) {
    on<LoginVisibilityEvent>((event, emit) {
      emit(LoginState(visibility: !state.visibility));
    });
    on<LoginSubmitEvent>((event, emit) async {
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: usernameController.text, password: pwController.text);
        if (user.user != null) {
          emit(LoginSucessState());
        } else {
          emit(LoginOnTapBackState());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          emit(LoginErrorState());
        }
      }
    });
  }
}
