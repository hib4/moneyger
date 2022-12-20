import 'package:flutter/material.dart';

class OnBoardingContents {
  final String title;
  final String image;
  final String desc;

  OnBoardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnBoardingContents> contents = [
  OnBoardingContents(
    title: "Selamat Datang di Moneyger",
    image: "assets/images/boardingone.png",
    desc: "Moneyger adalah aplikasi manajemen keuangan pribadi yang membantu Anda mengelola uang",
  ),
  OnBoardingContents(
    title: "Lacak Pengeluaran Anda",
    image: "assets/images/boardingtwo.png",
    desc: "Moneyger membantu Anda melacak pengeluaran dan pendapatan Anda",
  ),
  OnBoardingContents(
    title: "Kelola Anggaran Anda",
    image: "assets/images/boardingthree.png",
    desc: "Moneyger membantu Anda mengelola anggaran Anda",
  ),
];