import 'package:empmaster/constant.dart';
import 'package:empmaster/resources/onboardInfo.dart';
import 'package:empmaster/screens/login.dart';
import 'package:empmaster/screens/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class onboardingScreen extends StatefulWidget {
  const onboardingScreen({Key? key}) : super(key: key);

  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  _setInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('initScreen', 0);
    print('set init to 0');
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [
                      primaryColor.withOpacity(0.5),
                      primaryColor.withOpacity(0.5)
                    ],
                    [
                      primaryColor.withOpacity(0.7),
                      primaryColor.withOpacity(0.7)
                    ],
                  ],
                  durations: [35000, 20000],
                  heightPercentages: [0.83, 0.85],
                ),
                size: Size(double.infinity, double.infinity),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.w, 80.h, 50.w, 80.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 15.h, bottom: 5.h),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Bienvenue sur\n",
                                        style: TextStyle(
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.bold,
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
                                        text: "EmpMaster",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 28.sp,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: OnboardInfo(
                              icon: Iconify(
                                Uil.check_circle,
                                color: primaryColor,
                                size: 35.sp,
                              ),
                              title: 'Pointage Facile',
                              mainText:
                                  'Grace a EmpMaster vous pouvez pointer facilement votre présence au sein de votre lieu de travail.'),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 30.h),
                            child: OnboardInfo(
                                icon: Iconify(
                                  Carbon.calendar_heat_map,
                                  color: primaryColor,
                                  size: 35.sp,
                                ),
                                title: 'Historique de pointages',
                                mainText:
                                    "Vous aurez l'accés a votre historique de pointage ainsi que toutes les informations concernant ces derniers.")),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: OnboardInfo(
                              icon: Iconify(
                                Uil.user_circle,
                                color: primaryColor,
                                size: 35.sp,
                              ),
                              title: 'Créer et personaliser votre profil',
                              mainText:
                                  'Sur EmpMaster vous pouvez créer votre propre profil et le personaliser comme vous voulez.'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 80.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: Text(
                        "C'est partit!",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _setInit();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login(message: '')));
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
