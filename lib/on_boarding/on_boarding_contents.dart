import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to Moneyger",
    image: "assets/images/boardingone.png",
    desc: "Moneyger is a personal finance management app that helps you to manage your money",
  ),
  OnboardingContents(
    title: "Track your expenses",
    image: "assets/images/boardingtwo.png",
    desc: "Moneyger helps you to track your expenses and income",
  ),
  OnboardingContents(
    title: "Manage your budget",
    image: "assets/images/boardingthree.png",
    desc: "Moneyger helps you to manage your budget",
  ),
];