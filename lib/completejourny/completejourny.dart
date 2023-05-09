import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/completejourny/complete_model.dart';
import 'package:unwaste/profileview.dart';
import 'package:http/http.dart'as http;
import 'package:unwaste/uploadclass.dart';
import '../CustomSingleDialog.dart';
import '../appconstants/appconstants.dart';

class CompleteJournyPage extends StatefulWidget {
  const CompleteJournyPage({Key? key}) : super(key: key);

  @override
  State<CompleteJournyPage> createState() => _CompleteJournyPageState();
}

class _CompleteJournyPageState extends State<CompleteJournyPage> {
  String sessionmobile="";
  String sessiontoken="";
  String sessiondriverID="";
  String sessionname="";
  String sessionrouteid="";
  String sessiondate="";
  String sessionwastageid="";
  bool loading=false;
  CompleteModel completemodel=CompleteModel();
  @override
  void initState() {
    getStringValuesSF();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        /*appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text('Home-Dashboard',style: TextStyle(color: Colors.black87,fontSize: 16),),
          actions: [
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profileview()));
            }, child: Image.asset('assets/images/avatarmale.png',height: 40,width: 40,))
          ],
        ),*/
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text('Home - Dashboard',style: TextStyle(color: Colors.black87,fontSize: 16),),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profileview()));
            }, child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset('assets/images/avatarmale.png',height: 40,width: 40,),
            ))
          ],
        ),
        body: !loading?Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Hello, Welcome',style: TextStyle(fontSize: 12,color: Colors.black54),),
              SizedBox(height: 5,),
              Text(sessionname,style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius:BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Text('Driver ID : ${sessiondriverID}',style: TextStyle(fontSize: 12),),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius:BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text('Route No. : ${sessionrouteid}',style: TextStyle(fontSize: 12),),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius:BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.brown),
                    ),
                    child: Text('Date : ${sessiondate}',style: TextStyle(fontSize: 12),),
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
              Text('List of Appartments',style: TextStyle(fontSize: 16),),
              SizedBox(height: 25,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:completemodel.data!.isNotEmpty? ListView.builder(
                        itemCount:completemodel.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Row(
                              children: [
                                Expanded(child: Container(
                                    margin: EdgeInsets.all(12),
                                    child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                        color: Colors.grey.shade200,
                                        child: Image.asset('assets/images/dashlogo.png',width: 40,height: 40,))),flex: 2),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(completemodel.data![index].name.toString(),style: TextStyle(fontSize: 16,color: Colors.black54),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.navigation,color: Colors.blue,size:14,),
                                          Text('${completemodel.data![index].address.toString()},${completemodel.data![index].area.toString()}',style: TextStyle(fontSize: 12,color: Colors.black54),),
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
                                          Icon(Icons.delete_outline_outlined,color: Colors.red,size:20,),
                                          Text('Bin/Bag - ',style: TextStyle(fontSize: 12,color: Colors.black54),),
                                          SizedBox(width: 3,),
                                          Text('${completemodel.data![index].wastageCount.toString()}',style: TextStyle(fontSize: 14,color: Colors.black87,fontWeight: FontWeight.bold),),
                                          Expanded(
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 20),
                                                  child: Icon(Icons.check_circle,color: Colors.green,size: 18,),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),flex: 8,),
                              ],
                            ),
                          );
                        }):Center(child: Text('No Data!'),
                  ),
                ),
                ),
              )
            ],
          ),
        ):CircularProgressIndicator(),
        bottomNavigationBar:!loading? ElevatedButton(style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.blue)
                )
            )
        ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadScreen()));
            //_getCurrentPosition();
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Complete Journey',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
  Future getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessiondriverID = prefs.getString('DriverID').toString();
    sessiontoken = prefs.getString('Token').toString();
    sessionmobile = prefs.getString('Phone').toString();
    sessionname = prefs.getString('Name').toString();
    sessionrouteid = prefs.getString('RouteId').toString();
    sessionwastageid = prefs.getString('WastageID').toString();
    sessiondate = prefs.getString('Date').toString();
    print(sessiontoken);
    setState(() {

    });

    getcompletedjournylist();
  }

  Future<void> getcompletedjournylist() async {
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken',};

    var body = {
      "date":AppConstants.cdate,
      "route_id":sessionrouteid,
      "driver_id":sessiondriverID,
    };

    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/route-assigning/get-completed-apartment-list-day'),
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
         /* dashboardModel = DashboardModel.fromJson(jsonDecode(response.body));
          print(jsonDecode(response.body))*/;
          completemodel=CompleteModel.fromJson(jsonDecode(response.body));
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
      setState(() =>endjourney(position.latitude,position.longitude));
    }).catchError((e) {
      debugPrint(e);
    });*/
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


    endjourney(position.latitude,position.longitude);

  }
  Future<void> endjourney(lat,lang) async {

    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken'};
    var body = {

      "date":AppConstants.cdate,
      "route_id":sessionrouteid,
      "driver_id":sessiondriverID,
      "start_apartment_id":"3",
      "lat":lat,
      "lng":lang,
      "vehicle_id":"2"
    };
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/journey-log/edit'),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));
      print(headers);
      setState(() {
        loading = false;
      });
      print('REPOSD  ${jsonDecode(response.body)}');
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

          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('${jsonDecode(response.body)['message'].toString()}'),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UploadScreen()));
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
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
        // logoutfunction(context);
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
