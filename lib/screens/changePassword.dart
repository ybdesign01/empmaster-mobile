// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:empmaster/models/apiResponse.dart';
import 'package:empmaster/services/userService.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:empmaster/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

class changePasswordScreen extends StatefulWidget {
  const changePasswordScreen({Key? key}) : super(key: key);

  @override
  State<changePasswordScreen> createState() => _changePasswordScreenState();
}

class _changePasswordScreenState extends State<changePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isObscure = true;
  bool _isObscure2 = true;
  TextEditingController txtPassword = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  void _updatePass() async {
    ApiResponse response = await updatePassword(passwordConfirm.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${response.error}')));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
                extendBody: true,
                extendBodyBehindAppBar: true,
                backgroundColor: backgroundColor,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(80.0),
                  child: AppBar(
                    leading: Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: IconButton(
                        splashRadius: 1,
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          size: 40,
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: primaryColor,
                      ),
                    ),
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Container(
                      padding: EdgeInsets.only(top: 30.h, left: 0, right: 50),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              width: 128.w,
                            )
                          ]),
                    ),
                  ),
                ),
                body: Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.5,
                        image: ExactAssetImage("assets/images/empattern2.png"),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(20.h, 50.h, 20.h, 20.h),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 500.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.25),
                                  spreadRadius: -1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: formKey,
                                child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: Center(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: Text(
                                                  'Changer votre mot de passe',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 50.0),
                                              child: Text(
                                                  'Votre mot de passe doit contenir minimum 6 caractères',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11.sp)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 20.h,
                                                  left: 20.w,
                                                  right: 20.w),
                                              child: TextFormField(
                                                controller: txtPassword,
                                                validator: (val) => val!
                                                            .length <
                                                        6
                                                    ? 'Mot de passe min 6 caractères'
                                                    : null,
                                                textAlign: TextAlign.center,
                                                autocorrect: true,
                                                obscureText: _isObscure,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Entrez votre mot de passe',
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _isObscure
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure =
                                                            !_isObscure;
                                                      });
                                                    },
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(1.w),
                                                  filled: true,
                                                  prefixIcon: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.h, 0, 5.h, 0),
                                                      child: Iconify(Uil.lock,
                                                          color: darkColor,
                                                          size: 5.0)),
                                                  hintStyle: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: 'Inter',
                                                      color: Colors.grey[400]),
                                                  fillColor: Colors.grey[100],
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color: primaryColor
                                                            .withOpacity(0.3),
                                                        width: 2),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color: primaryColor
                                                            .withOpacity(0.3),
                                                        width: 2),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color: primaryColor
                                                            .withOpacity(0.3),
                                                        width: 2),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 2),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color: primaryColor
                                                            .withOpacity(0.3),
                                                        width: 2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 20.h,
                                                  left: 20.w,
                                                  right: 20.w),
                                              child: TextFormField(
                                                controller: passwordConfirm,
                                                validator: (val) => val !=
                                                        txtPassword.text
                                                    ? 'Mot de passes différents'
                                                    : null,
                                                textAlign: TextAlign.center,
                                                autocorrect: true,
                                                obscureText: _isObscure2,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Confirmer votre mot de passe',
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _isObscure2
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color: primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure2 =
                                                            !_isObscure2;
                                                      });
                                                    },
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(1.w),
                                                  filled: true,
                                                  prefixIcon: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.h, 0, 5.h, 0),
                                                      child: Iconify(Uil.lock,
                                                          color: darkColor,
                                                          size: 5.0)),
                                                  hintStyle: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: 'Inter',
                                                      color: Colors.grey[400]),
                                                  fillColor: Colors.grey[100],
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color: primaryColor
                                                            .withOpacity(0.3),
                                                        width: 2),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color: primaryColor
                                                            .withOpacity(0.3),
                                                        width: 2),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color: primaryColor
                                                            .withOpacity(0.3),
                                                        width: 2),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 2),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    borderSide: BorderSide(
                                                        color: primaryColor
                                                            .withOpacity(0.3),
                                                        width: 2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 40.h),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: primaryColor,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 70.w,
                                                            vertical: 12.h),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40))),
                                                child: Text(
                                                  'Enregister',
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    _updatePass();
                                                  }
                                                },
                                              ),
                                            ),
                                          ]),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                )));
  }
}
