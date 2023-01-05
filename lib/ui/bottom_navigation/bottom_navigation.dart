import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/ui/bottom_navigation/item/budget.dart';
import 'package:moneyger/ui/bottom_navigation/item/home.dart';
import 'package:moneyger/ui/bottom_navigation/item/profile.dart';
import 'package:moneyger/ui/bottom_navigation/item/transaction.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final _tabs = [
    const HomePage(),
    const TransactionPage(),
    const BudgetPage(),
    const ProfilePage(),
  ];

  final _items = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/icons/home.svg'),
      activeIcon: SvgPicture.asset('assets/icons/home_active.svg'),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/icons/transaction.svg'),
      activeIcon: SvgPicture.asset('assets/icons/transaction_active.svg'),
      label: 'Transaksi',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/icons/transaction.svg'),
      activeIcon: SvgPicture.asset('assets/icons/transaction_active.svg'),
      label: 'Anggaran',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/icons/profile.svg'),
      activeIcon: SvgPicture.asset('assets/icons/profile_active.svg'),
      label: 'Profil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: ColorValue.primaryColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: textTheme.bodyText2,
        unselectedLabelStyle: textTheme.bodyText2,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        elevation: 5,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
