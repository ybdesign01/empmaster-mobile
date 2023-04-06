// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:empmaster/constant.dart';
import 'package:empmaster/screens/acceuil.dart';
import 'package:empmaster/screens/loading.dart';
import 'package:empmaster/screens/login.dart';
import 'package:empmaster/screens/onboard.dart';
import 'package:empmaster/screens/pointages.dart';
import 'package:empmaster/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  initScreen = prefs.getInt('initScreen');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 800),
        builder: (child) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              MonthYearPickerLocalizations.delegate,
            ],
            theme: ThemeData(
              primaryColor: primaryColor,
              splashColor: darkColor.withOpacity(0.2),
              fontFamily: 'Inter',
            ),
            debugShowCheckedModeBanner: false,
            home: initScreen != 0 ? onboardingScreen() : loading(),
          );
        });
  }
}
