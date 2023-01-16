import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/ui/auth/login/login.dart';
import 'package:moneyger/ui/auth/reset_password/reset_password_profile.dart';
import 'package:moneyger/ui/personal_information/edit_personal_information.dart';
import 'package:moneyger/ui/switch_theme.dart';
import 'package:moneyger/ui/widget/detail_transaction_item.dart';
import 'package:moneyger/ui/widget/user_item/user_item.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: provider.isDarkMode
          ? ColorValueDark.darkColor
          : const Color(0XFFF9F9F9),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 50, 28, 0),
              child: Column(
                children: [
                  ProfilePreviewItem(),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    color: Color(0XFFECEEF2),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      DetailTransactionItem(),
                      DetailTransactionItem(
                        isIncome: false,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
                decoration: BoxDecoration(
                  color: provider.isDarkMode
                      ? ColorValueDark.backgroundColor
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    _button(
                      textTheme,
                      onPress: () {
                        Navigate.navigatorPush(
                            context, const EditProfilePage());
                      },
                      icon: 'personal_info',
                      title: 'Edit Profil',
                      isDarkMode: provider.isDarkMode,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _button(
                      textTheme,
                      onPress: () {
                        Navigate.navigatorPush(
                            context, const ResetPasswordProfilePage());
                      },
                      icon: 'reset_password',
                      title: 'Reset Kata Sandi',
                      isDarkMode: provider.isDarkMode,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _button(
                      textTheme,
                      onPress: () {
                        Navigate.navigatorPush(
                            context, const SwitchThemePage());
                      },
                      icon: 'darkmode',
                      title: 'Ganti Tema',
                      isDarkMode: provider.isDarkMode,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _button(
                      textTheme,
                      onPress: () async {
                        await FirebaseAuth.instance.signOut();
                        await GoogleSignIn().signOut();
                        if (!mounted) return;
                        Navigate.navigatorPushAndRemove(
                            context, const LoginPage());
                      },
                      icon: 'logout',
                      title: 'Keluar',
                      isLogout: true,
                      isDarkMode: provider.isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(
    TextTheme textTheme, {
    required void Function() onPress,
    required String icon,
    required String title,
    required bool isDarkMode,
    bool isLogout = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        splashColor: isDarkMode ? ColorValueDark.backgroundColor : Colors.white,
        borderRadius: BorderRadius.circular(12.5),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? ColorValueDark.darkColor
                    : const Color(0XFFF9F9F9),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.5),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/$icon.svg',
                  fit: BoxFit.fill,
                  color: isLogout
                      ? Colors.red
                      : isDarkMode
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: textTheme.bodyText1!.copyWith(
                color: isLogout
                    ? Colors.red
                    : isDarkMode
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            const Spacer(),
            const Icon(Icons.navigate_next_sharp)
          ],
        ),
      ),
    );
  }
}
