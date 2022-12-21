import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/ui/widget/button_sign_in_google.dart';
import 'package:moneyger/ui/widget/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    'Masukkan email dan password untuk mendaftar',
                    style: textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    label: 'Masukkan nama lengkap',
                    controller: _fullNameController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextFormField(
                    label: 'Masukkan email',
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextFormField(
                    label: 'Masukkan password',
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Daftar'),
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
                  const ButtonSignInGoogle(),
                  const SizedBox(
                    height: 40,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: textTheme.bodyText1,
                      children: [
                        TextSpan(
                            text: 'Masuk',
                            style: textTheme.bodyText1!.copyWith(
                              color: ColorValue.secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Login')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
