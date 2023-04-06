import 'package:empmaster/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

class OnboardInfo extends StatelessWidget {
  final Iconify icon;
  final String mainText;
  final String title;

  OnboardInfo({required this.icon, required this.mainText, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 11.w),
          child: icon,
        ),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                ),
                Text(
                  mainText,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    color: darkColor,
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}
