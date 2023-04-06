import 'package:empmaster/constant.dart';
import 'package:empmaster/models/user.dart';
import 'package:empmaster/screens/changePassword.dart';
import 'package:empmaster/screens/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/apiResponse.dart';
import '../services/userService.dart';
import 'login.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}



class _profileScreenState extends State<profileScreen> {
  User user = User();
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _logoutUser() async {
    ApiResponse response = await logout();
    print(response.error);
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      user.nom = prefs.getString('nom') ?? '' ;
      user.prenom = prefs.getString('prenom')?? '';
      user.email = prefs.getString('email')?? '';
      user.id = prefs.getInt('userID')?? 0;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5)
                ],
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/icon.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.nom ?? '',
                        style: TextStyle(
                          color: darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        width: 3.sp,
                      ),
                      Text(
                        user.prenom ?? '',
                        style: TextStyle(
                          color: darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(user.email ?? ''),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 450.h,
              margin: EdgeInsets.only(left: 30.w, top: 15.h, right: 30.w),
              decoration: BoxDecoration(
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
                  padding: EdgeInsets.fromLTRB(20.w, 40.w, 20.w, 40.w),
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Wrap(
                        runSpacing: 20.h,
                        children: [
                          Ink(
                            // height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                 Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      editProfileScreen()));
                              },
                              splashColor: darkColor.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.all(10.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Iconify(Uil.user_circle,
                                        color: darkColor),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.h),
                                            child: Text(
                                              'Modifier votre profile',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: darkColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Iconify(Uil.angle_right_b,
                                        color: darkColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Ink(
                            // height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      changePasswordScreen()));
                              },
                              splashColor: darkColor.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.all(10.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Iconify(Uil.lock,
                                        color: darkColor),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              'Changer votre mot de passe',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: darkColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Iconify(Uil.angle_right_b,
                                        color: darkColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Ink(
                          // height: 50.h,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              _logoutUser();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Login(message: '')),
                                  (route) => false);
                            },
                            splashColor: darkColor.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15.h),
                                          child: Text(
                                            'Se déconnecter',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Iconify(Uil.signout, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
