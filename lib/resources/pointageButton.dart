import 'package:empmaster/constant.dart';
import 'package:empmaster/models/apiResponse.dart';
import 'package:empmaster/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pointageButton extends StatefulWidget {
  final bool pointage;
  final bool pointageS;
  Function onPress;
  pointageButton(
      {Key? key,
      required this.pointage,
      required this.pointageS,
      required this.onPress})
      : super(key: key);

  @override
  State<pointageButton> createState() => _pointageButtonState();
}

class _pointageButtonState extends State<pointageButton> {
  @override
  Widget build(BuildContext context) {
    if (!widget.pointage) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: secondaryColor,
            padding: EdgeInsets.fromLTRB(60.w, 15.h, 60.h, 15.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
        child: Text(
          'Pointer votre entrée ->',
          maxLines: 1,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          widget.onPress();
        },
      );
    } else {
      if (!widget.pointageS) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: primaryColor,
              padding: EdgeInsets.fromLTRB(60.w, 15.h, 60.h, 15.w),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          child: Text(
            'Pointer votre sortie ->',
            maxLines: 1,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            widget.onPress();
          },
        );
      } else {
        return Text(
          "Vous avez déjà pointé aujourd'hui.",
          maxLines: 1,
          style: TextStyle(
            fontSize: 11.sp,
            color: darkColor,
            fontWeight: FontWeight.bold,
          ),
        );
      }
    }
  }
}
