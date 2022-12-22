import 'package:flutter/material.dart';
import 'package:moneyger/common/navigate.dart';
import 'package:moneyger/ui/auth/login/login.dart';
import 'package:moneyger/ui/auth/register/register.dart';
import 'package:moneyger/ui/on_boarding/on_boarding_contents.dart';
import 'package:moneyger/ui/on_boarding/size_config.dart';
import 'package:moneyger/common/color_value.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List colors = [Colors.white, Colors.white, Colors.white];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        color: _currentPage == index
            ? ColorValue.primaryColor
            : ColorValue.secondaryColor.withOpacity(0.5),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = SizeConfig.screenH!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: (height * 0.9) - MediaQuery.of(context).padding.top,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Moneyger",
                          style: textTheme.headline1!.copyWith(
                            color: ColorValue.primaryColor,
                            letterSpacing: 5,
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 35,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          contents[i].title,
                          style: textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          contents[i].desc,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyText1!.copyWith(
                            color: const Color(0xff9B9B9B),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          height: 72,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: (height * 0.13) - MediaQuery.of(context).padding.top,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _currentPage + 1 == contents.length
                      ? Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(0);
                                },
                                style: TextButton.styleFrom(
                                    elevation: 0,
                                    textStyle: textTheme.headline4),
                                child: const Text("Kembali"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  contents.length,
                                  (int index) => _buildDots(index: index),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigate.navigatorReplacement(
                                      context, const LoginPage());
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: textTheme.headline4!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                child: const Text("Mulai"),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: textTheme.headline4!
                                      .copyWith(color: Colors.red),
                                ),
                                child: const Text("Lewati"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  contents.length,
                                  (int index) => _buildDots(index: index),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: textTheme.headline4!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                child: const Text("Lanjut"),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
