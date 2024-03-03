import 'package:booking_admin/components/btn/button_outline.dart';
import 'package:booking_admin/components/btn/button_primary.dart';
import 'package:booking_admin/components/dialog/dialog_primary.dart';
import 'package:booking_admin/components/text_field/text_field_default.dart';
import 'package:booking_admin/components/top_bar/topbar_no_background.dart';
import 'package:booking_admin/feature/bottom_navi.dart';
import 'package:booking_admin/feature/signup/bloc/signup_bloc.dart';
import 'package:booking_admin/source/colors.dart';
import 'package:booking_admin/source/typo.dart';
import 'package:booking_admin/source/utils/validate_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/signup_event.dart';
import 'bloc/signup_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static String routeName = 'signup_page';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          onTapBack();
          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavi.routeName, (route) => false);
        }
        if (state is SignupErrorUserState) {
          //remove loading
          onTapBack();
          showDialog(
            context: context,
            builder: (context) {
              return DialogPrimary(
                  content: 'Tài khoản đã tồn tại',
                  buttonText: 'Đồng ý',
                  onTap: onTapBack);
            },
          );
        }
        if (state is SignupErrorNetworkState) {
          //remove loading
          onTapBack();
          showDialog(
            context: context,
            builder: (context) {
              return DialogPrimary(
                  content: 'Lỗi kết nối mạng',
                  buttonText: 'Đồng ý',
                  onTap: onTapBack);
            },
          );
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
                      key: context.read<SignupBloc>().formKey,
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
                                  context.read<SignupBloc>().usernameController,
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<SignupBloc, SignupState>(
                              builder: (context, state) {
                                return InputDefault(
                                  hintText: 'Nhập mật khẩu',
                                  obscureText: state.visibility,
                                  validator: ValidateUntils.validatePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller:
                                      context.read<SignupBloc>().pwController,
                                  suffixIcon: InkWell(
                                    onTap: onTapVisibility,
                                    child: state.visibility == true
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            InputDefault(
                              hintText: 'Nhập tên của bạn',
                              obscureText: false,
                              validator: ValidateUntils.validateName,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller:
                                  context.read<SignupBloc>().nameController,
                            ),
                            const SizedBox(height: 16),
                            InputDefault(
                              hintText: 'Nhập số điện thoại',
                              obscureText: false,
                              validator: ValidateUntils.validatePhonenumber,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: context
                                  .read<SignupBloc>()
                                  .phoneNumbereController,
                            ),
                            const SizedBox(height: 16),
                            InputDefault(
                              hintText: 'Nhập CMND',
                              obscureText: false,
                              validator: ValidateUntils.validateName,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller:
                                  context.read<SignupBloc>().cmndController,
                            ),
                            const SizedBox(height: 16),
                            InputDefault(
                              hintText: 'Nhập địa chỉ',
                              obscureText: false,
                              validator: ValidateUntils.validateName,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller:
                                  context.read<SignupBloc>().diaChiController,
                            ),
                            const SizedBox(height: 16),
                            InputDefault(
                              hintText: 'Nhập mã khách sạn',
                              obscureText: false,
                              validator: ValidateUntils.validateName,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller:
                                  context.read<SignupBloc>().maCtyController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ButtonPrimary(
                        text: 'Tiếp tục',
                        onTap: onTapSignup,
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
              Text('Bạn đã có tài khoản? ', style: tStyle.BaseBoldBlack()),
              InkWell(
                  onTap: onTapBack,
                  child: Text('Đăng nhập', style: tStyle.BaseBoldPrimary())),
            ],
          ),
        ),
      ),
    );
  }

  void onTapBack() {
    Navigator.pop(context);
  }

  void onTapVisibility() {
    context.read<SignupBloc>().add(SignupVisibilityEvent());
  }

  void onTapSignup() async {
    if (context.read<SignupBloc>().formKey.currentState!.validate()) {
      // add loading
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          });
      context.read<SignupBloc>().add(SignupSubmitEvent());
    }
  }
}
