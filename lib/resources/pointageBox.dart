import 'package:empmaster/constant.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/icons/fa.dart';
import 'package:intl/intl.dart';

class pointageBox extends StatelessWidget {
  final String date;
  final String localisation;
  final String heure;
  final Function pressed;

  const pointageBox(
      {required this.date,
      required this.localisation,
      required this.heure,
      required this.pressed});

  @override
  Widget build(BuildContext context) {
    Color colored = darkColor;
    var df = DateFormat("kk:mm");
    var dt = df.parse('08:30');
    var dd = df.parse('08:00');

    if (df.parse(heure).isAfter(dt)) {
      colored = primaryColor;
    }

    if (df.parse(heure).isAfter(dd) && df.parse(heure).isBefore(dt)) {
      colored = secondaryColor;
    }

    return InkWell(
      onTap: () {
        pressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: -1,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: darkColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 160.w,
                            child: Text(
                              localisation,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: darkColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Text(
                        heure,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: colored,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Plus de détails ->',
                    style:
                        TextStyle(fontSize: 11.sp, color: Colors.grey.shade400),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
