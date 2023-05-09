import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/CustomSingleDialog.dart';
import 'package:unwaste/apartmentview/apartment_model.dart';
import 'package:unwaste/completejourny/completejourny.dart';
import 'package:unwaste/dashboard/RouteModel.dart';
import 'package:unwaste/login/login_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;
import '../appcolors.dart';
import '../appconstants/appconstants.dart';
import '../customformbutton.dart';
import '../dashboard/start_journymodel.dart';
import 'PostLocation.dart';

class ApartmentView extends StatefulWidget {
   ApartmentView({Key? key,/*required this.routeModel,required this.routeposition*/}) : super(key: key,);


  @override
  State<ApartmentView> createState() => _ApartmentViewState();
}

class _ApartmentViewState extends State<ApartmentView> {
  Uint8List bytes = Uint8List(0);
  late TextEditingController _outputController;
  int qty=0;
  String sessionmobile="";
  String sessiontoken="";
  String sessiondriverID="";
  String sessionname="";
  String sessionrouteid="";
  String sessionwastageid="";
  bool loading=false;
  ApartmentModel model=ApartmentModel();
  int totalapartmentcount=0;
  int currentapartmentcount=0;
  String buttonname="";
  int?nodata=0;
  bool qtycon =false;
  Timer? _timer;
  @override
  initState() {
    super.initState();
    //int routeposition1=routeposition;
    this._outputController = new TextEditingController();
    getStringValuesSF();
    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
      PostLocationState().getCurrentPosition();
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

   Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Apartment View',style: TextStyle(color: Colors.black87,fontSize: 18),),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back,color: Colors.black87,)),
      ),
      body: !loading?SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
          child: Column(
            children: [
              Card(
                // Define the shape of the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                // Define how the card's content should be clipped
                clipBehavior: Clip.antiAliasWithSaveLayer,
                // Define the child widget of the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    // Add padding around the row widget
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child:model.data![0].apartment!.isNotEmpty? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Add an image widget to display an image
                          Image.asset('assets/images/apartmentview1.png',
                            height:200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          // Add some spacing between the image and the text
                          SizedBox(
                            height: 10,
                          ),
                          Text(model.data![0].apartment![0].name.toString()=="null"?"-":model.data![0].apartment![0].name.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/iconnavigate.png',color: AppColors.kdashblue,height: 18,width: 18,),
                                SizedBox(width: 5,),
                                Text('${model.data![0].apartment![0].area.toString()==null?"-":model.data![0].apartment![0].area.toString()},${model.data![0].apartment![0].address.toString()=="null"?"-":model.data![0].apartment![0].address.toString()}',style: TextStyle(fontSize: 10),),
                              ],
                            ),
                          ),
                        ],
                      ):Center(child: Text('No Data!')),
                    ),
                  ],
                )//:Center(child: Text('No data'),),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width *0.9,
                height: 45,
                child: ElevatedButton.icon(onPressed: ()=> openMapsSheet(context),/*navigateTo(double.parse(widget.modell.data![0].lat.toString()),double.parse(widget.modell.data![0].lng.toString())),*/ icon: Icon(Icons.location_on,color: Colors.white,),label: Text('Navigate'),style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent //elevated btton background color
                ),),
              ),
              SizedBox(height: 10,),
              model.data![0].apartment!.isNotEmpty?Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 45,
                child: ElevatedButton.icon(onPressed: () {
                    scan();
                    }, icon: Icon(Icons.qr_code,color: Colors.white,),label: Text('Scan QR'),style: ElevatedButton.styleFrom(
                    primary: Colors.black87 //elevated btton background color
                ),),
              ):Container(),
              SizedBox(height: 10,),
              model.data![0].apartment!.isNotEmpty?
              Text(model.data![0].apartment![0].name.toString().isEmpty?"-":model.data![0].apartment![0].name.toString(),style: TextStyle(fontSize: 16),):Text(''),
              SizedBox(
                height: 10,
              ),
              Text('Bin/Bag Count'),
              SizedBox(
                height: 15,
              ),
              Center(
                /*child: Container(
                  width: 100,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).accentColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 16,
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        padding:
                        EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white),
                        child: Text(
                          '0',
                          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.normal),
                        ),
                      ),
                      InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          )),
                    ],
                  ),
                ),*/
                child:Visibility(
                  visible: qtycon,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.lightBlue)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            decrement();
                          },
                          child: const Icon(
                            Icons.remove,
                            size: 18,
                            color: AppColors.lightBlue,
                          ),
                        ),
                        Text(
                          qty.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.lightBlue,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            increment();
                          },
                          child: Icon(
                            Icons.add,
                            size: 18,
                            color: AppColors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              !loading?Container(
                //width: size.width * 0.8,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xDD000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: model.data![0].apartment!.isNotEmpty?TextButton(
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>const CompleteJournyPage()));
                      if(qty==0){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Qty..')),);
                      }else {
                        submitwastage();
                      }
                    },
                    child: Text('Save', style: const TextStyle(color: Colors.white, fontSize: 20),),
                  ):Container()
              ):Center(child: CircularProgressIndicator(),),
              SizedBox(
                height: 15,
              ),
             /* !loading?Container(
                //width: size.width * 0.8,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xDD000000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>const CompleteJournyPage()));
                    submitwastage();
                  },
                  child: Text('Submit', style: const TextStyle(color: Colors.white, fontSize: 20),),
                )
              ):Center(child: CircularProgressIndicator(),),*/
            ],
          ),
        ),

      ):Center(child: CircularProgressIndicator(),),
    ));
  }


  void increment(){
    setState(() {
      if(qty>=1000){
        return;
      }
      qty=qty+1;
    });
  }
  void decrement(){
    setState(() {
      if(qty<1){
        return;
      }
      qty=qty-1;
    });
  }
  Future scan() async {
    print('inside');
    await Permission.camera.request();
    String ? barcode = await scanner.scan();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (barcode == null) {
      print('nothing return.');
      setState(() {
        qtycon=false;
      });
      showDialog(
        barrierColor: Colors.black26,
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialogSingle(
            title: "Invalid Barcode",
            description: _outputController.text,
          );
        },
      );
    } else {
      _outputController.text="";
      this._outputController.text = barcode;


      try{

        var _distanceInMeters = await Geolocator.distanceBetween(
          double.parse(model.data![0].apartment![0].lat.toString()),
          double.parse(model.data![0].apartment![0].lng.toString()),
          position.latitude,
          position.longitude,
        );
        if(_distanceInMeters>100){
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Text('Distance Between  100 Meters only!'),
              )
          );
        }else{
          setState(() {
            if(barcode.toString()==model.data![0].apartment![0].qrcode.toString()){
            print('BARCODE ${barcode}');
            qtycon=true;
          }else{
            qtycon=false;
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text('Invalid QR Code'),
                )
            );
          }
        });
        }
      }catch(e){
        print(e.toString());
      }

    }
  }

  Future getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessiondriverID = prefs.getString('DriverID').toString();
    sessiontoken = prefs.getString('Token').toString();
    sessionmobile = prefs.getString('Phone').toString();
    sessionname = prefs.getString('Name').toString();
    sessionrouteid = prefs.getString('RouteId').toString();
    sessionwastageid = prefs.getString('WastageID').toString();
    print(sessiontoken);

    getlist();
  }

  Future<void> getlist() async {
    setState(() {
      loading = true;
    });
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken'};
    var body = {

      "date":AppConstants.cdate,
      "route_id":sessionrouteid,
      "driver_id":sessiondriverID
    };
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/route-assigning/get-driver-assigned-apartment'),
          body: jsonEncode(body),
          headers: headers);
      print(jsonEncode(body));
      print(headers);
      setState(() {
        loading = false;
      });
      //print('REPOSD  ${jsonDecode(response.body)}');
     // print('REPOSDD ${jsonDecode(response.body)['apartment']}');

      if (response.statusCode == 200) {
        if ('${jsonDecode(response.body)['success'].toString()}' == "false") {
          model.data![0].apartment=null;
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

          model=ApartmentModel.fromJson(jsonDecode(response.body));
          totalapartmentcount=int.parse(model.data![0].totalApartmentCount.toString());
          currentapartmentcount=int.parse(model.data![0].wastageLogAddedApartmentCount.toString());
          //print('PRINT${model.data![0].apartment![0].name.toString()=="null"?"-":""}');

          if(totalapartmentcount==currentapartmentcount){
            print('COUNT COMPLETE${totalapartmentcount-currentapartmentcount}');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                CompleteJournyPage()));
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

  Future<void> submitwastage() async {

    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken'};
    var body = {

      "vehicle_id":"1",
      "driver_id":sessiondriverID,
      "apartment_id":model.data![0].apartment![0].id.toString(),
      "route_master_id":sessionrouteid,
      "wastage_id":sessionwastageid.toString(),
      "wastage_count":qty,
      "date":AppConstants.cdate,
      "status":0,
      "photo":'',
      "remarks":"Test"
    };
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
          Uri.parse(AppConstants.LIVE_URL + 'api/wastage-log/create'),
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
                description: '${jsonDecode(response.body)['message'].toString()}',
              );
            },
          );
        } else {
          /*SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(top: 100.0),
            content: Text('${jsonDecode(response.body)['message'].toString()}'),
          );*/
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
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ApartmentView()));
                    },
                  ),
                ],
              );
            },
          );
          //setState(() {});
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

  openMapsSheet(context) async {
    try {
      final coords = Coords(double.parse(model.data![0].apartment![0].lat.toString().toString()), double.parse(model.data![0].apartment![0].lng.toString().toString()));
      final title = model.data![0].apartment![0].name.toString().toString();
      final availableMaps = await MapLauncher.installedMaps;
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        /*leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),*/
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
  logoutfunction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool("LoggedIn", false);
      prefs.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(),),(route) => false,
      );
    });
  }
}
