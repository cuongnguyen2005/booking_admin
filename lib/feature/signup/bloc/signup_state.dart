class SignupState {
  final bool visibility;
  SignupState({
    this.visibility = true,
  });
}

class SignupInitial extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupErrorUserState extends SignupState {}

class SignupErrorNetworkState extends SignupState {}
