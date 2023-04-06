import 'package:empmaster/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:empmaster/screens/login.dart';
import 'package:empmaster/screens/home.dart';
import 'package:empmaster/models/apiResponse.dart';
import 'package:empmaster/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  void resetToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
  }

  void _getUserInfo() async {
    String token = await getToken();
    print('loading token:' + token);
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login(message: '')),
          (route) => false);
    } else {
      ApiResponse response = await getUser();
      if (response.error == null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login(message: '')),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
