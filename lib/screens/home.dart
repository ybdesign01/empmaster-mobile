import 'dart:async';
import 'package:empmaster/constant.dart';
import 'package:empmaster/screens/acceuil.dart';
import 'package:empmaster/screens/pointages.dart';
import 'package:empmaster/screens/profile.dart';
import 'package:empmaster/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../resources/stateBox.dart';
// ignore_for_file: prefer_const_constructors

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  PageController? _pageController;
  String? _time;
  static const List<Widget> _widgetOptions = <Widget>[
    acceuilScreen(),
    pointagesScreen(),
    profileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _pageController?.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: BottomNavigationBar(
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              backgroundColor: darkColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Acceuil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Pointages',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
              unselectedItemColor: Color(0xFFAFBEDA).withOpacity(0.2),
              selectedItemColor: Color(0xFFAFBEDA),
            ),
          ),
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
               automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.only(top: 30.h),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: <Widget>[
                _widgetOptions.elementAt(0),
                _widgetOptions.elementAt(1),
                _widgetOptions.elementAt(2)
              ],
            ),
          ),
        ));
  }
}
