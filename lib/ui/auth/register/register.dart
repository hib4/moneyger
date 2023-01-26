import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/service/firebase_service.dart';
import 'package:moneyger/ui/auth/login/login.dart';
import 'package:moneyger/ui/auth/verification/verification.dart';
import 'package:moneyger/ui/widget/button_sign_in_google.dart';
import 'package:moneyger/ui/widget/custom_text_form_field.dart';
import 'package:moneyger/ui/widget/loading/loading_animation.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _isLoad = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<ThemeProvider>(context);

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
                          color: provider.isDarkMode
                              ? ColorValueDark.secondaryColor
                              : ColorValue.secondaryColor,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          'Daftar Akun',
                          style: textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Masukkan form di bawah untuk mendaftar',
                          style: textTheme.bodyText2,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextFormField(
                          label: 'Masukkan nama lengkap',
                          controller: _fullNameController,
                          validator: (value) =>
                              SharedCode().nameValidator(value),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                          label: 'Masukkan email',
                          controller: _emailController,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) =>
                              SharedCode().emailValidator(value),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                          label: 'Masukkan kata sandi',
                          controller: _passwordController,
                          isPassword: true,
                          validator: (value) =>
                              SharedCode().passwordValidator(value),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _isLoad.value = true;
                              await FirebaseService()
                                  .signUpEmail(
                                    context,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                    fullName: _fullNameController.text,
                                  )
                                  .then(
                                    (value) => value
                                        ? Navigate.navigatorPushAndRemove(
                                            context, const VerificationPage())
                                        : null,
                                  );
                              _isLoad.value = false;
                            }
                          },
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
                        GestureDetector(
                          onTap: () async {
                            await FirebaseService().signInGoogle(context).then(
                                  (value) => value
                                      ? Navigate.navigatorPushAndRemove(
                                          context, const VerificationPage())
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
                            text: 'Sudah punya akun? ',
                            style: textTheme.bodyText1,
                            children: [
                              TextSpan(
                                text: 'Masuk',
                                style: textTheme.bodyText1!.copyWith(
                                  color: provider.isDarkMode
                                      ? ColorValueDark.secondaryColor
                                      : ColorValue.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigate.navigatorPush(
                                      context, const LoginPage()),
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
