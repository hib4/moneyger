import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/shared_code.dart';

class WelcomeNameItem extends StatelessWidget {
  WelcomeNameItem({Key? key}) : super(key: key);

  final _document =
      FirebaseFirestore.instance.collection('users').doc(SharedCode().uid);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _document.get(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;

          return Text(
            'Hai, ${data['full_name'].toString().split(' ').first}',
            style: textTheme.headline2!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          );
        } else {

          // ganti dengan shimmer effect
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class TotalBalanceItem extends StatelessWidget {
  final TextStyle textStyle;

  TotalBalanceItem({Key? key, required this.textStyle}) : super(key: key);

  final _document =
      FirebaseFirestore.instance.collection('users').doc(SharedCode().uid);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _document.get(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;

          return Text(
            SharedCode().convertToIdr(data['total_balance'], 0),
            style: textStyle,
          );
        } else {

          // ganti dengan shimmer effect
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ProfilePreviewItem extends StatelessWidget {
  ProfilePreviewItem({Key? key}) : super(key: key);

  final _document =
      FirebaseFirestore.instance.collection('users').doc(SharedCode().uid);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _document.get(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;

          return Column(
            children: [
              CircleAvatar(
                backgroundColor: ColorValue.secondaryColor,
                radius: 50,
                child: Text(
                  SharedCode().getInitials(data['full_name']),
                  style: textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                data['full_name'],
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(data['email'], style: textTheme.bodyText1),
            ],
          );
        } else {

          // ganti dengan shimmer effect
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
