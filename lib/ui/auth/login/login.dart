import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/service/firebase_service.dart';
import 'package:moneyger/ui/auth/register/register.dart';
import 'package:moneyger/ui/auth/reset_password/reset_password.dart';
import 'package:moneyger/ui/auth/verification/verification.dart';
import 'package:moneyger/ui/home.dart';
import 'package:moneyger/ui/widget/button_sign_in_google.dart';
import 'package:moneyger/ui/widget/custom_text_form_field.dart';
import 'package:moneyger/ui/widget/loading/loading_animation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _isLoad = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/logo.svg',
                          width: size.width * 0.25,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          'Selamat Datang',
                          style: textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Masukkan email dan password untuk masuk',
                          style: textTheme.bodyText2,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextFormField(
                          label: 'Masukkan email',
                          controller: _emailController,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) =>
                              SharedCode().emailValidator(value),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          label: 'Masukkan password',
                          controller: _passwordController,
                          isPassword: true,
                          validator: (value) =>
                              SharedCode().passwordValidator(value),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigate.navigatorPush(
                                  context, const ResetPasswordPage());
                            },
                            child: Text(
                              'Lupa password?',
                              style: textTheme.bodyText2!.copyWith(
                                color: ColorValue.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _isLoad.value = true;
                              await FirebaseService()
                                  .signInEmail(
                                    context,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                  )
                                  .then(
                                    (value) => value
                                        ? Navigate.navigatorPush(
                                            context, const VerificationPage())
                                        : null,
                                  );
                              _isLoad.value = false;
                            }
                          },
                          child: const Text('Masuk'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Atau',
                          style: textTheme.bodyText2,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseService().signInGoogle(context).then(
                                  (value) => value
                                      ? Navigate.navigatorPush(
                                          context, const HomeTest())
                                      : null,
                                );
                          },
                          child: const ButtonSignInGoogle(),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Belum punya akun? ',
                            style: textTheme.bodyText1,
                            children: [
                              TextSpan(
                                text: 'Daftar',
                                style: textTheme.bodyText1!.copyWith(
                                  color: ColorValue.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigate.navigatorPush(
                                      context, const RegisterPage()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isLoad,
              builder: (context, value, _) => Visibility(
                visible: value,
                child: const LoadingAnimation(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
