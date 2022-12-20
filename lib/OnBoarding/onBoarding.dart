import 'package:flutter/material.dart';
import 'package:moneyger/OnBoarding/OnboardingContents.dart';
import 'package:moneyger/OnBoarding/SizeConfig.dart';
import 'package:moneyger/common/color_value.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 40, left: 40, right: 40),
                    child: Column(
                      children: [
                        Text("Moneyger",
                            style: textTheme.headline4!.copyWith(
                                color: ColorValue.primaryColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 5)),
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 35,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 60 : 30,
                        ),
                        Text(
                          contents[i].title,
                          style: textTheme.headline5!.copyWith(
                            color: ColorValue.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          contents[i].desc,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyText1!.copyWith(
                            color: Color(0xff9B9B9B),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage + 1 == contents.length
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 50, right: 30, left: 30, top: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: (width <= 550) ? 13 : 17,
                            ),
                          ),
                          child: const Text(
                            "Kembali",
                            style: TextStyle(color: ColorValue.primaryColor),
                          ),
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
                            Navigator.pushNamed(context, '/login');
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 13 : 17,
                            ),
                          ),
                          child: const Text("Start", style: TextStyle(
                              color: ColorValue.primaryColor
                          ),),
                        ),
                      ],
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(bottom: 50, right: 30, left: 30, top: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _controller.jumpToPage(2);
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: (width <= 550) ? 13 : 17,
                            ),
                          ),
                          child: const Text(
                            "Skip",
                            style: TextStyle(color: ColorValue.primaryColor),
                          ),
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
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 13 : 17,
                            ),
                          ),
                          child: const Text("Next", style: TextStyle(
                              color: ColorValue.primaryColor
                          ),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
