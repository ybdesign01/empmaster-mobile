// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:empmaster/constant.dart';
import 'package:empmaster/models/apiResponse.dart';
import 'package:empmaster/services/userService.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class editProfileScreen extends StatefulWidget {
  const editProfileScreen({Key? key}) : super(key: key);

  @override
  State<editProfileScreen> createState() => _editProfileScreenState();
}

class _editProfileScreenState extends State<editProfileScreen> {
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtNom = TextEditingController();
  TextEditingController txtPrenom = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtNom.text = prefs.getString('nom') ?? '';
      txtPrenom.text = prefs.getString('prenom') ?? '';
      txtEmail.text = prefs.getString('email') ?? '';
    });
  }

  void _editUser() async {
    ApiResponse response =
        await updateProfile(txtNom.text, txtPrenom.text, txtEmail.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${response.error}')));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nom', txtNom.text);
    await prefs.setString('prenom', txtPrenom.text);
    await prefs.setString('email', txtEmail.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
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
                resizeToAvoidBottomInset: true,
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
                                                  bottom: 40.0),
                                              child: Text(
                                                  'Informations Personnelles',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: TextFormField(
                                                controller: txtNom,
                                                validator: (val) => val!.isEmpty
                                                    ? 'Nom Invalide.'
                                                    : null,
                                                textAlign: TextAlign.center,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                  hintText: 'Entrez votre nom',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 0, right: 40.w),
                                                  filled: true,
                                                  prefixIcon: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.h, 0, 5.h, 0),
                                                      child: Iconify(
                                                          Uil.user_circle,
                                                          color: darkColor,
                                                          size: 5.0)),
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'Inter',
                                                    color: Colors.grey[400],
                                                    fontSize: 11.sp,
                                                  ),
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
                                                  top: 10, left: 20, right: 20),
                                              child: TextFormField(
                                                controller: txtPrenom,
                                                validator: (val) => val!.isEmpty
                                                    ? 'Prénom Invalide.'
                                                    : null,
                                                onChanged: (val) {
                                                  var prenom = val;
                                                },
                                                textAlign: TextAlign.center,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Entrez votre prenom',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 0, right: 40.w),
                                                  filled: true,
                                                  prefixIcon: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.h, 0, 5.h, 0),
                                                      child: Iconify(
                                                          Uil.user_circle,
                                                          color: darkColor,
                                                          size: 5.0)),
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'Inter',
                                                    color: Colors.grey[400],
                                                    fontSize: 11.sp,
                                                  ),
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
                                                  top: 30, left: 20, right: 20),
                                              child: TextFormField(
                                                controller: txtEmail,
                                                validator: (val) => val!.isEmpty
                                                    ? 'Email Invalide.'
                                                    : null,
                                                textAlign: TextAlign.center,
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Entrez votre email',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 0, right: 40.w),
                                                  filled: true,
                                                  prefixIcon: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.h, 0, 5.h, 0),
                                                      child: Iconify(
                                                          Uil.envelope,
                                                          color: darkColor,
                                                          size: 5.0)),
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'Inter',
                                                    color: Colors.grey[400],
                                                    fontSize: 11.sp,
                                                  ),
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
                                                    _editUser();
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
