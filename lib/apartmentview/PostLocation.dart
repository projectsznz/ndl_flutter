import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../appconstants/appconstants.dart';

class PostLocation extends StatefulWidget {
  const PostLocation({Key? key}) : super(key: key);

  @override
  State<PostLocation> createState() => PostLocationState();
}

class PostLocationState extends State<PostLocation> {

  String sessionmobile="";
  String sessiontoken="";
  String sessiondriverID="";
  String sessionname="";
  String sessionrouteid="";
  late  bool serviceEnabled;
  late LocationPermission permission;
  bool islocationenable=false;
  @override
  void initState() {
    // TODO: implement initState
    getsession();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Future getsession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessiondriverID = prefs.getString('DriverID').toString();
    sessiontoken = prefs.getString('Token').toString();
    sessionmobile = prefs.getString('Phone').toString();
    sessionname = prefs.getString('Name').toString();
    sessionrouteid = prefs.getString('RouteId').toString();
   // print(sessiontoken);
    //_getCurrentPosition();
  }
  void getStringValuesSF() async {

    //getsession().then((value) => _getCurrentPosition());

    //await getsalesupdatehaderoffline();
  }

  Future<void> getCurrentPosition() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessiondriverID = prefs.getString('DriverID').toString();
    sessiontoken = prefs.getString('Token').toString();
    sessionmobile = prefs.getString('Phone').toString();
    sessionname = prefs.getString('Name').toString();
    sessionrouteid = prefs.getString('RouteId').toString();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


    postlocation(position.latitude,position.longitude,sessiontoken);
  }

  Future<void> determinepostion() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      islocationenable=false;
      return Future.error('Location services are denied');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      islocationenable=false;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        islocationenable=false;
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      islocationenable=false;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    islocationenable=true;
    print(islocationenable);

    getCurrentPosition();
  }
 Future<void> postlocation(lat,lang,sessiontoken) async {

    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer ${sessiontoken}',};

    var body = {
      "vehicle_link":'1',
      "lat":lat.toString(),
      "lng":lang.toString(),
      "status":0,
    };
    print(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/vehicle/save-tracking'),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));

      print('REPOSD  ${jsonDecode(response.body)['status']}');


      if (response.statusCode == 200) {
        if ('${jsonDecode(response.body)['success'].toString()}' == "false") {
          print(response.body);
        } else {
          print(response.body);
        }
      } else {

      }
    } on SocketException {

      throw Exception('Internet is down');
    }
  }

}
