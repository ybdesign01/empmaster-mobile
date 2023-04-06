// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:empmaster/models/apiResponse.dart';
import 'package:empmaster/resources/pointageBox.dart';
import 'package:empmaster/screens/details.dart';
import 'package:empmaster/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:intl/intl.dart';
import '../constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class pointagesScreen extends StatefulWidget {
  const pointagesScreen({Key? key}) : super(key: key);

  @override
  State<pointagesScreen> createState() => _pointagesScreenState();
}

class _pointagesScreenState extends State<pointagesScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime _selected = DateTime.now();
  TextEditingController dateinput = TextEditingController();
  bool isLoading = false;
  String mois = '';
  var c;

  List<Map<String, dynamic>> pointages = [];
  
  void _onPressed() async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateFormat('yyyy-MM-dd').parse('2022-12-31'),
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
        mois = DateFormat('MM').format(_selected);
        String formattedDate = DateFormat.MMMM('fr').format(_selected);
        dateinput.text = formattedDate;
      });
    } else {
      dateinput.text = 'Choisir un mois';
    }
  }

  void getP() async {
    List<Map<String, dynamic>> p = [];
    c = await getPointages(mois);
    if (c != null) {
      for (var i in c) {
        Map<String, dynamic> o = <String, dynamic>{};
        o.addAll({
          'id': i['id_pointage'],
          'date_pointage': DateFormat("dd/MM/yyyy")
              .format(DateTime.parse(i['date_pointage'])),
          'localisation_entre': i['localisation_entre'],
          'heure_pointage': i['heure_pointage']
        });
        p.add(o);
      }
      if (mounted) {
        setState(() {
          pointages = p;
        });
      }
      print(pointages);
    } else {
      print('No pointages for this mois');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    dateinput.text = 'Choisir un mois';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            ),
          )
        : Form(
            child: Padding(
              padding: EdgeInsets.all(30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.h, 20.h, 20.h, 10.h),
                    child: Container(
                      height: 40.h,
                      width: 220.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: darkColor.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 45.w),
                        child: TextFormField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.grey[700],
                            fontSize: 12.sp,
                          ),
                          showCursor: false,
                          enableInteractiveSelection: false,
                          controller: dateinput,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 4.h),
                            icon: Iconify(Uil.calendar_alt, color: darkColor),
                            hintText: dateinput.text,
                            border: InputBorder.none,
                          ),
                          onTap: () async {
                            _onPressed();
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(200.w, 35.h),
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: Text(
                        'Continuer',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        getP();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 450.h,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Center(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(children: [
                                  if (pointages.isNotEmpty)
                                    for (var i in pointages)
                                      pointageBox(
                                        date: i['date_pointage'],
                                        localisation: i['localisation_entre'],
                                        heure: i['heure_pointage'],
                                        pressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      detailsScreen(id: i['id'])));
                                        },
                                      )
                                  else
                                    Column(
                                      children: [
                                        Iconify(Carbon.close_outline),
                                        Text('Aucun pointage'),
                                      ],
                                    )
                                ]),
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
