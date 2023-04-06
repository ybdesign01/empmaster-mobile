import 'package:empmaster/constant.dart';
import 'package:empmaster/services/userService.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';

class detailsScreen extends StatefulWidget {
  final int id;
  const detailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<detailsScreen> createState() => _detailsScreenState();
}

class _detailsScreenState extends State<detailsScreen> {
  bool isLoading = true;
  Map<String, dynamic> point = <String, dynamic>{};
  @override
  void initState() {
    // TODO: implement initState
    print(widget.id);
    getP();
    super.initState();
  }

  void getP() async {
    List<Map<String, dynamic>> p = [];
    var c = await getPointage(widget.id.toString());
    point = c[0];
    print(point);
    setState(() {
      isLoading = false;
    });
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
                backgroundColor: backgroundColor,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(80.0),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Container(
                      padding: EdgeInsets.only(top: 30.h, left: 0, right: 0),
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
                    padding: EdgeInsets.all(20.h),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
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
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat("dd/MM/yyyy").format(
                                            DateTime.parse(
                                                point['date_pointage'])),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: darkColor,
                                            fontSize: 20.sp),
                                      ),
                                      SizedBox(
                                        height: 100.h,
                                      ),
                                      Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/point_yellow.png',
                                            width: 24.sp,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Heure d'entrée: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.sp)),
                                              Text(point['heure_pointage'],style:
                                                  TextStyle(fontSize: 15.sp)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            "Localisation d'entrée:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(point['localisation_entre'],
                                              style:
                                                  TextStyle(fontSize: 15.sp)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Image.asset(
                                        'assets/images/point_red.png',
                                        width: 24.sp,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Heure de sortie: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.sp)),
                                              Text(point['heure_pointage_fin'],style:
                                                  TextStyle(fontSize: 15.sp)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text("Localisation de sortie: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp)),
                                          Text(point['localisation_sortie'],style:
                                                  TextStyle(fontSize: 15.sp)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 150.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(200.w, 35.h),
                                              primary: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40))),
                                          child: Text(
                                            '<- Retour',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ]),
                              ),
                            )),
                      ),
                    ),
                  )),
                )),
          );
  }
}
