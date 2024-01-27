import 'package:booking_admin/components/btn/button_outline.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/dialog/dialog_primary.dart';
import 'package:booking_admin/components/text_field/text_field_default.dart';
import 'package:booking_admin/components/top_bar/topbar_no_background.dart';
import 'package:booking_admin/feature/bottom_navi.dart';
import 'package:booking_admin/feature/login/bloc/login_event.dart';
import 'package:booking_admin/feature/signup/signup.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:booking_admin/source/utils/validate_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String routeName = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSucessState) {
          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavi.routeName, (route) => false);
        }
        if (state is LoginErrorState) {
          //remove loading
          onTapBack();
          showDialog(
            context: context,
            builder: (context) {
              return DialogPrimary(
                content: 'Tài khoản hoặc mật khẩu không đúng',
                buttonText: 'Đồng ý',
                onTap: onTapBack,
              );
            },
          );
        }
        if (state is LoginOnTapBackState) {
          onTapBack();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/Herobanner.png',
                      width: double.infinity,
                      height: size.height * 1 / 3,
                      fit: BoxFit.cover,
                    ),
                    Form(
                      key: context.read<LoginBloc>().formKey,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            InputDefault(
                              hintText: 'Nhập email',
                              obscureText: false,
                              validator: ValidateUntils.validateEmail,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller:
                                  context.read<LoginBloc>().usernameController,
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return InputDefault(
                                  hintText: 'Nhập mật khẩu',
                                  obscureText: state.visibility,
                                  validator: ValidateUntils.validatePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller:
                                      context.read<LoginBloc>().pwController,
                                  suffixIcon: InkWell(
                                    onTap: onTapVisibility,
                                    child: state.visibility == true
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ButtonPrimary(
                        text: 'Tiếp tục',
                        onTap: onTapLogin,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: AppColors.lightGrey,
                              height: 1,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              ' Hoặc đăng nhập/đăng ký với ',
                              style: tStyle.BaseRegularGrey(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: AppColors.lightGrey,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ButtonOutline(
                        text: 'Google',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ButtonOutline(
                        text: 'Facbook',
                        onTap: () {},
                      ),
                    ),
                    Container(height: 60),
                  ],
                ),
              ],
            ),
            const TopBarNoBackground(text: '')
          ],
        ),
        bottomSheet: Container(
          height: 50,
          color: AppColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bạn chưa có tài khoản? ', style: tStyle.BaseBoldBlack()),
              InkWell(
                  onTap: onTapSignup,
                  child: Text('Đăng ký', style: tStyle.BaseBoldPrimary())),
            ],
          ),
        ),
      ),
    );
  }

  void onTapVisibility() {
    context.read<LoginBloc>().add(LoginVisibilityEvent());
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapSignup() {
    Navigator.pushNamed(context, SignupPage.routeName);
  }

  void onTapLogin() async {
    if (context.read<LoginBloc>().formKey.currentState!.validate()) {
      //add loading
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          });
      context.read<LoginBloc>().add(LoginSubmitEvent());
    }
  }
}
