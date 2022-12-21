import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/ui/auth/login/login.dart';
import 'package:moneyger/ui/auth/register/register.dart';
import 'package:moneyger/ui/home.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final ValueNotifier<bool> _isEmailVerified = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _canResendEmail = ValueNotifier<bool>(false);
  Timer? timer;

  Future _sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      _canResendEmail.value = false;
      await Future.delayed(const Duration(seconds: 60));
      _canResendEmail.value = true;
    } catch (e) {
      print(e.toString());
    }
  }

  Future _checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    _isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (_isEmailVerified.value) {
      timer?.cancel();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!_isEmailVerified.value) {
      _sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => _checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder<bool>(
      valueListenable: _isEmailVerified,
      builder: (context, value, _) => value
          ? const HomeTest()
          : Scaffold(
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/verification.png',
                        width: size.width * 0.7,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Periksa email anda',
                        style: textTheme.headline2!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Kami telah mengirimkan pesan verifikasi\n(cek dibagian spam)',
                        style: textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _canResendEmail,
                        builder: (context, value, _) => ElevatedButton(
                          onPressed: value ? _sendVerificationEmail : null,
                          child: const Text('Kirim Ulang'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();
                          if (!mounted) return;
                          Navigate.navigatorPushAndRemove(
                              context, const LoginPage());
                        },
                        child: const Text('Keluar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
