import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeadlineItem extends StatelessWidget {
  final String image, title, desc;

  const HeadlineItem(
      {Key? key, required this.image, required this.title, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        SvgPicture.asset(
          'assets/svg/$image.svg',
          width: 32,
          height: 32,
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              desc,
              style: textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
