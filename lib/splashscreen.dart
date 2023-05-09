import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/dashboard/dashboard.dart';
import 'package:unwaste/uploadclass.dart';

import 'login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? islogged;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringValuesSF();
  }
  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 3),() =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>islogged==false?LoginPage():Dashboardpage())));
    /*   ? LoginScreen()
                : islogged == null
                    ? LoginScreen()
                    : DashboardScreen())));*/
    var assetsImage = AssetImage(
        'assets/images/splash1.png',); //<- Creates an object that fetches an image.
    var image = Image(
        image: assetsImage,
        height: MediaQuery.of(context)
            .size
            .height,); //<- Creates a widget that displays an image.
    return   Container(
            width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(color: Colors.white),
          child: Image.asset("assets/images/splash/splash1.jpg"),//<- place where the image appears
    );
  }
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getBool('LoggedIn') == null ? islogged = false : islogged = true;

      print(islogged);
    });
  }
}
