// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:empmaster/constant.dart';
import 'package:empmaster/models/apiResponse.dart';
import 'package:empmaster/models/user.dart';
import 'package:empmaster/resources/pointageButton.dart';
import 'package:empmaster/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/stateBox.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// ignore_for_file: prefer_const_constructors

class acceuilScreen extends StatefulWidget {
  const acceuilScreen({Key? key}) : super(key: key);

  @override
  State<acceuilScreen> createState() => _acceuilScreenState();
}

class _acceuilScreenState extends State<acceuilScreen> {
  String? _time;
  bool _isLoading = false;
  DateFormat dateFormat = DateFormat.MMMMEEEEd('fr');
  var Date;
  late Timer v;
  User user = User();
  late Position _currentPosition;
  String _currentAddress = '';
  bool pointer = false;
  var retard;
  bool pointerS = false;
  String? heurePointageEntre;
  String? heurePointageSortie;

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  Future<void> getHeuresFunction() async {
    Map<String, dynamic> data = await getHeures();
    print(data);
    if (data.isNotEmpty) {
      print('Heurepointage:' + data["heurePointageEntre"].toString());
      print('HeurepointageS:' + data["heurePointageSortie"].toString());
      setState(() {
        heurePointageEntre = data["heurePointageEntre"];
        heurePointageSortie = data["heurePointageSortie"];
      });
    } else {
      print('empty array');
    }
  }

  void getRetard() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retard = prefs.getBool('retard');
    print('retard: '+ retard.toString());
  }

  Future<void> pointerFunction() async {
    if (heurePointageEntre == '--:--') {
      ApiResponse response = await pointerEntre(_currentAddress, _time!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      retard = response.data;
      print('retarddata: ' + retard.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('retard', retard);
    } else {
      ApiResponse response = await pointerSortie(_currentAddress, _time!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  Future<void> getPointage() async {
    Map<String, dynamic> data = await checkPointage();
    print(data);
    if (data.isNotEmpty) {
      print('pointage:' + data['pointage'].toString());
      print('pointageS:' + data['pointageS'].toString());
      setState(() {
        pointer = data['pointage'];
        pointerS = data['pointageS'];
      });
    } else {
      print('empty array');
    }
  }

  Future<void> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.nom = prefs.getString('nom');
    user.prenom = prefs.getString('prenom');
    user.email = prefs.getString('email');
    user.id = prefs.getInt('userID');
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    setState(() {
      _isLoading = true;
    });
    Position p = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _currentPosition = p;
        _getAddressFromLatLng();
        _isLoading = false;
      });
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.thoroughfare}, ${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    getPointage();
    _getUser();
    getDate();
    getRetard();
    getHeuresFunction();
    _time = _formatDateTime(DateTime.now());
    v = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    initializeDateFormatting();
    _determinePosition();
    super.initState();
    setState(() {
      _isLoading = false;
    });
    print(_isLoading);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (mounted) {
      setState(() {
        _time = formattedDateTime;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  void getDate() {
    setState(() {
      Date = (dateFormat.format(DateTime.now())).split(' ');
    });
  }

  @override
  void dispose() {
    super.dispose();
    v.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              stateBox(
                  pointed: pointer,
                  retard: retard ?? true,
                  user: user.nom ?? ''),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 450.h,
                  margin: EdgeInsets.only(left: 30, right: 30),
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
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _time!,
                                style: TextStyle(
                                  color: darkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                toBeginningOfSentenceCase(Date[0])! +
                                    ', ' +
                                    Date[1] +
                                    ' ' +
                                    toBeginningOfSentenceCase(Date[2])!,
                                style: TextStyle(
                                  color: Color(0xFF8D99AE),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Iconify(Carbon.location,
                                        color: Color(0xFF8D99AE), size: 26),
                                    Expanded(
                                      child: Text(
                                        _currentAddress,
                                        style: TextStyle(
                                          color: Color(0xFF8D99AE),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 17.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ]),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(30.w, 50.w, 30.w, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/point_entre.png',
                                          width: 24.sp,
                                        ),
                                        Text(
                                          heurePointageEntre ?? '--:--',
                                          style: TextStyle(
                                            color: darkColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/point_sortie.png',
                                          width: 24.sp,
                                        ),
                                        Text(
                                          heurePointageSortie ?? '--:--',
                                          style: TextStyle(
                                            color: darkColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 60.h),
                                child: pointageButton(
                                  pointage: pointer,
                                  pointageS: pointerS,
                                  onPress: () {
                                    setState(() {
                                      if (heurePointageEntre == "--:--") {
                                        pointerFunction();
                                        heurePointageEntre = _time!;
                                        getHeures();
                                      } else {
                                        pointerFunction();
                                        heurePointageSortie = _time!;
                                        getHeures();
                                      }
                                    });
                                    getPointage();
                                  },
                                ),
                              ),
                            ],
                          ))),
                ),
              )
            ],
          );
  }
}
