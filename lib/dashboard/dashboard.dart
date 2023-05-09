import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/apartmentview/apartment_view.dart';
import 'package:unwaste/appcolors.dart';
import 'package:unwaste/profileview.dart';
import 'package:http/http.dart'as http;

import '../CustomSingleDialog.dart';
import '../apartmentview/PostLocation.dart';
import '../appconstants/appconstants.dart';
import 'dashboardmodel.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({Key? key}) : super(key: key);
  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  String sessionmobile="";
  String sessiontoken="";
  String sessionname="";
  String sessionid="";
  String sessionroutemasterid="";
  String sessiondate="";
  //RouteModel modell=RouteModel(data: []);

  DashboardModel dashboardModel=DashboardModel(data: []);

  bool loading=false;
  late int postionselect=0;
  var clickapartmentid="";
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  bool startjourny=false;

  var isTracking = false;
  Timer? _timer;
  List<String> _locations = [];
  @override
  void initState() {
    print(cdate);

    getStringValuesSF();

    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
      PostLocationState().getCurrentPosition();
    });
    // _listenLocation();
    // Timer.periodic(const Duration(seconds: 30), (_) => _listenLocation());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    dashboardModel.data!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text('Home - Dashboard',style: TextStyle(color: Colors.black87,fontSize: 16),),
        actions: [
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profileview()));
          },child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset('assets/images/avatarmale.png',height: 40,width: 40,),
          )),
        ],
      ),
        body:!loading? Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Text('Hello,Welcome',style: TextStyle(fontSize: 12,color: Colors.black54),),
             SizedBox(height: 5,),
             Text(sessionname,style: TextStyle(fontWeight: FontWeight.bold),),
             SizedBox(height: 5,),
             Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                      borderRadius:BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: AppColors.kdashblue),
                  ),
                  child: Text('Driver ID : ${sessionid.toString()}',style: TextStyle(fontSize: 12),),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius:BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.green),
                  ),
                  child: dashboardModel.data!.length>0?Text('Route : ${dashboardModel.data![postionselect].routeMasterName}',style: TextStyle(fontSize: 12),):Text('Route : ${sessionroutemasterid}',style: TextStyle(fontSize: 12),),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade50,
                    borderRadius:BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: AppColors.kdashbrown),
                  ),
                  child: Text('Date : ${sessiondate}',style: TextStyle(fontSize: 12,color: Colors.brown),),
                ),
              ],
              ),
             SizedBox(height: 5,),
             Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.8,
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Text('List of Apartments',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                  TextButton.icon(onPressed: (){
                    checkjournystartornot();
                  }, icon: Icon(Icons.refresh,color: Colors.white), label: Text('Refresh',style: TextStyle(color: Colors.white))
                    ,style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFF192C49)),maximumSize: MaterialStatePropertyAll(Size(120,36))),)
                ],
              ),
              SizedBox(height: 25,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: dashboardModel.data!.length>0?
                    ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                print('select');
                                postionselect=index;
                                print(postionselect);
                              });
                            },
                            child:dashboardModel.data![postionselect].apartment!.isNotEmpty? Card(
                              color: postionselect==index?Colors.white :Colors.white,
                              child: Row(
                                children: [
                                  Expanded(child:
                                  Container(
                                      margin: EdgeInsets.all(12),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                          color: Colors.grey.shade200,
                                          child: Image.asset('assets/images/dashlogo.png',width: 40,height: 40,))),flex: 2),
                                  Expanded(child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Text(dashboardModel.data![postionselect].apartment![index].name.toString(),style: TextStyle(fontSize: 16),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/images/iconnavigate.png',color: AppColors.kdashblue,height: 18,width: 18,),
                                            SizedBox(width: 5,),
                                            Text('${dashboardModel.data![postionselect].apartment![index].address.toString()},${dashboardModel.data![postionselect].apartment![index].area.toString()}',style: TextStyle(fontSize: 12,color: Colors.black54),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20.0),
                                        child: Divider(
                                          color: Colors.grey.shade400,
                                          height: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          children: [
                                            Image.asset('assets/images/iconbinbag.png',width: 20,height: 20,),
                                            SizedBox(width: 5,),
                                            Text('Bin/Bag - ',style: TextStyle(fontSize: 12,color: Colors.black54),),
                                            Text('0',style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),flex: 8,),
                                ],
                              ),
                            ):Container(child: Center(child: Text('NoData'),)),
                          );
                        }):Center(child: Text('No Data!'),),
                  ),
                )
              ),
            ],
          ),
        ):Center(child: CircularProgressIndicator(),),
        bottomNavigationBar:
          Visibility(
            //visible: startjourny,
            child: ElevatedButton(style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.blue)
                  )
              )
        ),
            onPressed: dashboardModel.data!.length==0?null:() async {
            /*  if (dashboardModel.data!.length == 0) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data should not empty!')),);
              } else {*/
                  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                  final SharedPreferences prefs = await _prefs;
                  prefs.setString("RouteId", dashboardModel.data![postionselect].routeMasterId.toString());
                  //prefs.setString("RouteId", dashboardModel.data![postionselect].routeMasterId.toString());
                  prefs.setString("VehicleId", dashboardModel.data![postionselect].vehicleId.toString());
                  prefs.setString("JournyEndId", dashboardModel.data![postionselect].id.toString());
                  prefs.setString("RouteName", dashboardModel.data![postionselect].routeMasterName.toString());
                 _getCurrentPosition();
              //}
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Start Journey',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ),
          ),
      ),
    );
  }
  Future getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessiontoken = prefs.getString('Token').toString();
    sessionmobile = prefs.getString('Phone').toString();
    sessionname = prefs.getString('Name').toString();
    sessionid = prefs.getString('ID').toString();
    sessionroutemasterid = prefs.getString('RouteId').toString();
    sessiondate = prefs.getString('Date').toString();
    // getstartjournysinglelist();
    checkjournystartornot();
    //setState(() {});
  }

  Future<void> checkjournystartornot() async {
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken',};

    var body = {
      "date":AppConstants.cdate,
      "route_id":sessionroutemasterid,
      "driver_id":sessionid,
    };
    print(jsonEncode(body));
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
         // Uri.parse(AppConstants.LIVE_URL + 'api/journey-log/list'),
          Uri.parse(AppConstants.LIVE_URL + 'api/route-assigning/check-open-journey'),
          body: jsonEncode(body),
          headers: headers);
      //print(jsonEncode(body));

      //print('REPOSD  ${jsonDecode(response.body)['status']}');
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if ('${jsonDecode(response.body)['success'].toString()}' == "false") {
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialogSingle(
                title: "Failed",
                description: '${jsonDecode(response.body)['message']}',
              );
            },
          );
        } else {
          print('LENGTHHH${jsonDecode(response.body)['data'].length}');
          if(jsonDecode(response.body)['data']['is_open_journey'].toString()=="1"){
            getalreadylogged();

            //getstartjournysinglelist();
          }else{
            getstartjournysinglelist();
          }
        }
      } else {
        showDialog(
          barrierColor: Colors.black26,
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialogSingle(
              title: "Failed",
              description: "Failed to Connect Login Api",
            );
          },
        );
      }
    } on SocketException {
      setState(() {
        loading = false;
        showDialog(
            context: this.context,
            builder: (_) => AlertDialog(
                backgroundColor: Colors.black,
                title: Text(
                  "No Response!..",
                  style: TextStyle(color: Colors.purple),
                ),
                content: Text(
                  "Slow Server Response or Internet connection",
                  style: TextStyle(color: Colors.white),
                )));
      });
      throw Exception('Internet is down');
    }
  }

  Future<void> getalreadylogged() async {
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken',};

    var body = {
      "date":AppConstants.cdate
    };

    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/route-assigning/get-driver-assigned-route'),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));

      print('REPOSD  ${jsonDecode(response.body)['status']}');
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if ('${jsonDecode(response.body)['success'].toString()}' == "false") {
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialogSingle(
                title: "Failed",
                description: '${jsonDecode(response.body)['message']}',
              );
            },
          );
        } else {
          dashboardModel = DashboardModel.fromJson(jsonDecode(response.body));
          print(jsonDecode(response.body));

          Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
          final SharedPreferences prefs = await _prefs;
          prefs.setString("RouteId", dashboardModel.data![postionselect].routeMasterId.toString());
          //prefs.setString("RouteId", dashboardModel.data![postionselect].routeMasterId.toString());
          prefs.setString("VehicleId", dashboardModel.data![postionselect].vehicleId.toString());
          prefs.setString("JournyEndId", dashboardModel.data![postionselect].id.toString());
          prefs.setString("RouteName", dashboardModel.data![postionselect].routeMasterName.toString());

          setState(() {
            /*if(dashboardModel.data!.length == 0){

            }else{
              startjourny==true;
            }*/
            startjourny==false;

          });

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              ApartmentView()));
        }
      } else {
        showDialog(
          barrierColor: Colors.black26,
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialogSingle(
              title: "Failed",
              description: "Failed to Connect Login Api",
            );
          },
        );
      }
    } on SocketException {
      setState(() {
        loading = false;
        showDialog(
            context: this.context,
            builder: (_) => AlertDialog(
                backgroundColor: Colors.black,
                title: Text(
                  "No Response!..",
                  style: TextStyle(color: Colors.purple),
                ),
                content: Text(
                  "Slow Server Response or Internet connection",
                  style: TextStyle(color: Colors.white),
                )));
      });
      throw Exception('Internet is down');
    }
  }
  Future<void> getstartjournysinglelist() async {
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken',};

    var body = {
      "date":AppConstants.cdate
    };

    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/route-assigning/get-driver-assigned-route'),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));

      print('REPOSD  ${jsonDecode(response.body)['status']}');
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if ('${jsonDecode(response.body)['success'].toString()}' == "false") {
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialogSingle(
                title: "Failed",
                description: '${jsonDecode(response.body)['message']}',
              );
            },
          );
        } else {
          dashboardModel = DashboardModel.fromJson(jsonDecode(response.body));
          print(jsonDecode(response.body));

          setState(() {
            if(dashboardModel.data!.length == 0){
              startjourny==false;
            }else{
              startjourny==true;
            }
          });
        }
      } else {
        showDialog(
          barrierColor: Colors.black26,
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialogSingle(
              title: "Failed",
              description: "Failed to Connect Login Api",
            );
          },
        );
      }
    } on SocketException {
      setState(() {
        loading = false;
        showDialog(
            context: this.context,
            builder: (_) => AlertDialog(
                backgroundColor: Colors.black,
                title: Text(
                  "No Response!..",
                  style: TextStyle(color: Colors.purple),
                ),
                content: Text(
                  "Slow Server Response or Internet connection",
                  style: TextStyle(color: Colors.white),
                )));
      });
      throw Exception('Internet is down');
    }
  }

  Future<void> _getCurrentPosition() async {
    setState(() {
      loading=true;
    });
    /*await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
    setState(() =>journystart(position.latitude,position.longitude));
    }).catchError((e) {
    debugPrint(e);
    });*/
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


    journystart(position.latitude,position.longitude);
  }
  Future<void> journystart(lat,lang) async {
    setState(() {
      loading=true;
    });
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken',};

    var body = {
      "date":AppConstants.cdate,
      "route_id":dashboardModel.data![postionselect].routeMasterId.toString(),
      "driver_id":dashboardModel.data![postionselect].driverId.toString(),
      "start_apartment_id":dashboardModel.data![postionselect].apartment![postionselect].id.toString(),
      "lat":lat,
      "lng":lang,
      "vehicle_id":dashboardModel.data![postionselect].vehicleId.toString(),
    };
    print(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/journey-log/create'),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));

      print('REPOSD  ${jsonDecode(response.body)['status']}');

      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if ('${jsonDecode(response.body)['success'].toString()}' == "false") {
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialogSingle(
                title: "Failed",
                description: '${jsonDecode(response.body)['message']}',
              );
            },
          );
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              ApartmentView()));
        }
      } else {
        showDialog(
          barrierColor: Colors.black26,
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CustomDialogSingle(
              title: "Failed",
              description: "Failed to Connect Login Api",
            );
          },
        );
      }
    } on SocketException {
      setState(() {
        loading = false;
        showDialog(
            context: this.context,
            builder: (_) => AlertDialog(
                backgroundColor: Colors.black,
                title: Text(
                  "No Response!..",
                  style: TextStyle(color: Colors.purple),
                ),
                content: Text(
                  "Slow Server Response or Internet connection",
                  style: TextStyle(color: Colors.white),
                )));
      });
      throw Exception('Internet is down');
    }
  }
}
