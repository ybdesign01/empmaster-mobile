import 'dart:core';

import 'package:empmaster/constant.dart';
import 'package:empmaster/models/apiResponse.dart';
import 'package:empmaster/screens/passwordReset.dart';
import 'package:empmaster/screens/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../services/userService.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  void showMessage(String message) {
    if (message == '') {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }


  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      String token = await getToken();
      print('token:' + token);
      print(txtEmail.text);
      print(txtPassword.text);
      _saveAndRedirectToHome(response.data as User);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    await prefs.setString('nom', user.nom ?? '');
    await prefs.setString('prenom', user.prenom ?? '');
    await prefs.setString('email', user.email ?? '');
    await prefs.setInt('userID', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }


  @override
  void initState() {
    super.initState();
    Future(() async {
      showMessage(widget.message);
    });
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
                              Image.asset(
                                'assets/images/EM.png',
                                width: 60.h,
                              ),
                              if (!isKeyboard)
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.h, bottom: 5.h),
                                  child: Text(
                                    "Bienvenue",
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                      color: darkColor,
                                    ),
                                  ),
                                ),
                              if (!isKeyboard)
                                Text(
                                  "Connectez-vous pour continuer.",
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
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: txtEmail,
                                validator: (val) => val!.isEmpty
                                    ? "Adresse email invalide."
                                    : null,
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
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: TextFormField(
                              controller: txtPassword,
                              validator: (val) =>
                                  val!.isEmpty ? "Minimum 6 caractéres." : null,
                              onChanged: (val) {
                                var password = val;
                              },
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
                            padding: EdgeInsets.only(top: 20.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 80.w, vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              child: Text(
                                'Se connecter',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  _loginUser();
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.h, bottom: 5.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            passwordResetScreen()));
                              },
                              child: Text(
                                'Mot de passe oubliée ?',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Vous n'avez pas un compte? ",
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
                                      text: "Inscrivez-vous.",
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
    );
  }
}
