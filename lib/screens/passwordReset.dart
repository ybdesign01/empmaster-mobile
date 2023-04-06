import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

import '../constant.dart';

class passwordResetScreen extends StatefulWidget {
  const passwordResetScreen({Key? key}) : super(key: key);

  @override
  State<passwordResetScreen> createState() => _passwordResetScreenState();
}

class _passwordResetScreenState extends State<passwordResetScreen> {
  final bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("assets/images/empattern.png"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!isKeyboard)
                                Text(
                                  "Réinitialisation du mot de passe.",
                                  softWrap: true,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 21.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: darkColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: -3,
                                    blurRadius: 8,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: TextField(
                                onChanged: (val) {
                                  var email = val;
                                },
                                textAlign: TextAlign.center,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  hintText: 'Entrez votre email',
                                  contentPadding:
                                      EdgeInsets.only(top: 0, right: 40.w),
                                  filled: true,
                                  prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20.h, 0, 5.h, 0),
                                      child: Iconify(Uil.envelope,
                                          color: darkColor, size: 5.0)),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[400],
                                    fontSize: 11.sp,
                                  ),
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 80.w, vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              child: Text(
                                'Continuer',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
