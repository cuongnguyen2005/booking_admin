class LoginState {
  final bool visibility;
  LoginState({
    this.visibility = true,
  });
}

class LoginInitial extends LoginState {}

class LoginSucessState extends LoginState {}

class LoginErrorState extends LoginState {}

// class LoginErrorPassState extends LoginState {}

// class LoginErrorUserState extends LoginState {}

class LoginOnTapBackState extends LoginState {}
