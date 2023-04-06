import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/icons/fa.dart';

import '../constant.dart';

class stateBox extends StatelessWidget {
  final bool retard;
  final bool pointed;
  final String user;

  const stateBox(
      {required this.pointed, required this.retard, required this.user});

  @override
  Widget build(BuildContext context) {
    if (!pointed) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 30, right: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/card1.png"),
              fit: BoxFit.cover),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
                padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bienvenue, $user",
                      style: TextStyle(
                        color: darkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.w,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Vous n'avez pas encore pointé\naujourd'hui.",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w100,
                        fontSize: 11.w,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ))),
      );
    } else{
      if(!retard){
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.centerRight,
                image: ExactAssetImage("assets/images/card.png"),
                fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bienvenue, $user",
                        style: TextStyle(
                          color: darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.w,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Vous étes arrivé en temps\naujourd'hui!",
                        style: TextStyle(
                          color: darkColor,
                          fontFamily: 'Inter',
                          fontSize: 11.w,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ))),
        );
      }else{
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/images/card2.png"),
                fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bienvenue, $user",
                        style: TextStyle(
                          color: darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.w,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Vous étes arrivé en retard\naujourd'hui.",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w100,
                          fontSize: 11.w,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ))),
        );
      }
    }
  }
}
