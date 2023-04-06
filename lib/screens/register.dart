// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:empmaster/screens/home.dart';
import 'package:empmaster/screens/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../models/apiResponse.dart';
import '../models/user.dart';
import '../services/userService.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({Key? key}) : super(key: key);

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  String? _dropdownValue;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController txtNom = TextEditingController();
  TextEditingController txtPrenom = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  

  void _registerUser() async {
    ApiResponse response = await register(txtEmail.text, txtPassword.text,
        txtNom.text, txtPrenom.text, _dropdownValue!);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Login(message: response.error!)),
        (route) => false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtEmail.dispose();
    txtPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Form(
          key: formKey,
          child: Container(
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
                                    "Veuillez entrer vos informations.",
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
                              child: TextFormField(
                                controller: txtNom,
                                validator: (val) =>
                                    val!.isEmpty ? 'Nom Invalide.' : null,
                                textAlign: TextAlign.center,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  hintText: 'Entrez votre nom',
                                  contentPadding:
                                      EdgeInsets.only(top: 0, right: 40.w),
                                  filled: true,
                                  prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20.h, 0, 5.h, 0),
                                      child: Iconify(Uil.user_circle,
                                          color: darkColor, size: 5.0)),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[400],
                                    fontSize: 11.sp,
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
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
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: TextFormField(
                                controller: txtPrenom,
                                validator: (val) =>
                                    val!.isEmpty ? 'Prénom Invalide.' : null,
                                onChanged: (val) {
                                  var prenom = val;
                                },
                                textAlign: TextAlign.center,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  hintText: 'Entrez votre prenom',
                                  contentPadding:
                                      EdgeInsets.only(top: 0, right: 40.w),
                                  filled: true,
                                  prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20.h, 0, 5.h, 0),
                                      child: Iconify(Uil.user_circle,
                                          color: darkColor, size: 5.0)),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[400],
                                    fontSize: 11.sp,
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
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
                            Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonFormField(
                                    validator: (val) => val == null
                                        ? 'Choisir un département'
                                        : null,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20.w, 0, 15.w, 0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            color:
                                                primaryColor.withOpacity(0.3),
                                            width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            color:
                                                primaryColor.withOpacity(0.3),
                                            width: 2),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            color:
                                                primaryColor.withOpacity(0.3),
                                            width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            color:
                                                primaryColor.withOpacity(0.3),
                                            width: 2),
                                      ),
                                    ),
                                    hint: Text('Choisir un département'),
                                    value: _dropdownValue,
                                    onChanged: (value) => setState(() {
                                      _dropdownValue = "$value";
                                    }),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('Resources Humaines'),
                                        value: '1',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Département Informatique'),
                                        value: '2',
                                      ),
                                    ],
                                    dropdownColor: Colors.white,
                                    isExpanded: true,
                                    alignment: Alignment.center,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: darkColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: TextFormField(
                                controller: txtEmail,
                                validator: (val) =>
                                    val!.isEmpty ? 'Email Invalide.' : null,
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
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
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
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: TextFormField(
                                controller: txtPassword,
                                validator: (val) => val!.length < 6
                                    ? 'Mot de passe min 6 caractères'
                                    : null,
                                textAlign: TextAlign.center,
                                autocorrect: true,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                  hintText: 'Entrez votre mot de passe',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(1.w),
                                  filled: true,
                                  prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20.h, 0, 5.h, 0),
                                      child: Iconify(Uil.lock,
                                          color: darkColor, size: 5.0)),
                                  hintStyle: TextStyle(
                                      fontSize: 11.sp,
                                      fontFamily: 'Inter',
                                      color: Colors.grey[400]),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
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
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: TextFormField(
                                controller: passwordConfirm,
                                validator: (val) => val != txtPassword.text
                                    ? 'Mot de passes différents'
                                    : null,
                                textAlign: TextAlign.center,
                                autocorrect: true,
                                obscureText: _isObscure2,
                                decoration: InputDecoration(
                                  hintText: 'Confirmer votre mot de passe',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure2 = !_isObscure2;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(1.w),
                                  filled: true,
                                  prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20.h, 0, 5.h, 0),
                                      child: Iconify(Uil.lock,
                                          color: darkColor, size: 5.0)),
                                  hintStyle: TextStyle(
                                      fontSize: 11.sp,
                                      fontFamily: 'Inter',
                                      color: Colors.grey[400]),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        color: primaryColor.withOpacity(0.3),
                                        width: 2),
                                  ),
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
                            Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 80.w, vertical: 12.h),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40))),
                                child: Text(
                                  'Créer votre compte',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    _registerUser();
                                  }
                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Déjà inscrit? ",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: darkColor,
                                          fontFamily: 'Inter',
                                        )),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        registerScreen()));
                                          },
                                        text: "Connectez-vous.",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 13.sp,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ))
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
      ),
    );
  }
}
