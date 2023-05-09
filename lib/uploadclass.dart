
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/completejourny/unitmatsermodel.dart';
import 'package:unwaste/dashboard/dashboard.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'CustomSingleDialog.dart';
import 'DashedRect.dart';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'dart:async';
import 'appconstants/appconstants.dart';
import 'customformbutton.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();

}

class _UploadScreenState extends State<UploadScreen> {
  late File file;
  List<String> files = [];
  List<String> attachmentlist =[];
  List<File> filelist = [];
  bool loading=false;
  String openlogid="";
  String selectedtype="";
  String sessionmobile="";
  String sessiontoken="";
  String sessiondriverID="";
  String sessionvehicleid="";
  String sessionjournylogendid="";

  String sessionname="";
  String sessionrouteid="";
  String sessionwastageid="";
  String selecttypeid="";

  //List<Data> typelist=[];
  List<Result> typelist = [];
  late unitmastermodel unitmodel;
  TextEditingController weightController=TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation:2,
        title: Text('Upload Garbage Weight',style: TextStyle(color: Colors.black87,fontSize: 16),),
        leading: Icon(Icons.arrow_back,color: Colors.black87,),
      ),
      body: SingleChildScrollView(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16,right: 16,top: 20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter Weight(kg/ton)'),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: TextField(
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              maxLength: 10,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),

                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  borderSide: BorderSide(color: Colors.black26, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  borderSide: BorderSide(color: Colors.black87, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  borderSide: BorderSide(color: Colors.black26, width: 1),
                                ),
                                filled: true,
                                fillColor: Color(0xffffffff),
                              ),
                            ),),
                            SizedBox(width: 20,),
                            Expanded(
                              flex: 6,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(5.0),
                               // width: MediaQuery.of(context).size.width * 0.30,
                                child: CustomSearchableDropDown(
                                  items: typelist,
                                  label: 'Select Type',
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Icon(Icons.search),
                                  ),
                                  dropDownMenuItems:
                                  typelist.map((item) {
                                    return item.name.toString();}).toList() ?? [],
                                  onChanged: (value) {
                                    if (value != null) {
                                      selectedtype = value.name.toString();
                                      selecttypeid = value.id.toString();
                                      //viewModel.setSupplierValue(selected as String?);
                                      print(selectedtype.toString());
                                      print(selecttypeid.toString());
                                    } else {
                                      selectedtype = "";
                                      selecttypeid = "";
                                    }
                                  },
                                ),
                              ))
                          ],
                        ),

                        SizedBox(height: 10,),
                        Text('Bill Photo'),
                        SizedBox(height: 5,),
                        InkWell(
                          onTap: (){
                            attachFile();
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.black12,
                            child: DashedRect(color: Colors.grey, strokeWidth: 1.0, gap: 3.0,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < filelist.length; i++)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Image.file(filelist[i]);
                                },
                              );
                            },
                            child: Container(
                                height: 100,
                                width: 100,
                                child: Image.file(filelist[i])),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.cancel,color: Colors.red,),
                            onTap: () {
                              setState(() {
                                filelist.removeAt(i);
                                files.removeAt(i);
                              });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Center(
                child:!loading? Container(
                  //width: size.width * 0.8,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xDD000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){
                      if(weightController.text.isEmpty){
                        showDialog(
                          barrierColor: Colors.black26,
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return CustomDialogSingle(
                              title: "Failed",
                              description: 'Please Enter Weight',
                            );
                          },
                        );
                      }else if(selectedtype.isEmpty){
                        showDialog(
                          barrierColor: Colors.black26,
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return CustomDialogSingle(
                              title: "Failed",
                              description: 'Please Choose Weight Type',
                            );
                          },
                        );
                      }else{
                        getopenjourneygetid();
                      }
                      //_getCurrentPosition();
                    },
                    child: Text('Submit', style: const TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ):Center(child: CircularProgressIndicator(),),
              )
            ],
          ),
      ),
    ));
  }
  showcomplete(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  Dialog(
            child: Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/thankyouimage.png'),
                  SizedBox(height: 10,),
                  Text("Thank you!!!",style:TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  Text("Your Daily task has been Completed.",style:TextStyle(fontSize: 14),),
                  SizedBox(height: 5,),
                  Text("Have a Nice day!. ",style:TextStyle(fontSize: 12),),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: !loading?CustomFormButton(innerText: 'Close', onPressed:(){
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboardpage()), (route) => false);

                    }):CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          );
        });
  }
  attachFile() async{
    files.clear();
    filelist.clear();
    attachmentlist.clear();
    final picker = ImagePicker();
    final pickedFile =
    await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      if (pickedFile != null) {
        filelist.add(File(pickedFile.path));
        attachmentlist.add(pickedFile.path
            .toString()
            .split("/")
            .last);
        files.add(pickedFile.path);
        print(files.length);

      } else {
        print('No image selected.');
      }
    });
  }
  Future getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessiondriverID = prefs.getString('DriverID').toString();
    sessiontoken = prefs.getString('Token').toString();
    sessionmobile = prefs.getString('Phone').toString();
    sessionname = prefs.getString('Name').toString();
    sessionrouteid = prefs.getString('RouteId').toString();
    sessionwastageid = prefs.getString('WastageID').toString();
    sessionvehicleid = prefs.getString('VehicleId').toString();
    sessionjournylogendid = prefs.getString('JournyEndId').toString();
    //print(sessiontoken);
   // typelist = prefs.getStringList("TypeList") ?? [];
    //print(typelist.length);_selectedtype=typelist.first;
    setState(() {

    });
    getunitmaster();
  }

  Future<void>getunitmaster() async{
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken',};
    var body = {

    };
    print(jsonEncode(body));
    setState(() {
      loading = true;
    });
    try {
      final response = await http.post(
        // Uri.parse(AppConstants.LIVE_URL + 'api/journey-log/list'),
          Uri.parse(AppConstants.LIVE_URL + 'api/weight-unit/list'),
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
         unitmodel=unitmastermodel.fromJson(jsonDecode(response.body));
         typelist.clear();
         for(int k=0;k<unitmodel.data!.length;k++){
           typelist.add(Result(int.parse(unitmodel.data![k].id.toString()),unitmodel.data![k].name.toString()));
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
  Future<void>getopenjourneygetid() async{
    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken',};
    var body = {
      "date":AppConstants.cdate,
      "route_id":sessionrouteid,
      "driver_id":sessiondriverID,
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
            openlogid=jsonDecode(response.body)['data']['journey_log_id'].toString();
            _getCurrentPosition(openlogid);
          }else{
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

  Future<void> _getCurrentPosition(openlogid) async {
    setState(() {
      loading=true;
    });
    /*await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() =>endjourney(position.latitude,position.longitude,openlogid));
    }).catchError((e) {
      debugPrint(e);
    });*/

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    endjourney(position.latitude,position.longitude,openlogid);
  }
  Future<void> endjourney(lat,lang,openlogid) async {

    var headers = {"Content-Type": "application/json",'Authorization': 'Bearer $sessiontoken'};
    var body = {

      "id":openlogid,
      "date":AppConstants.cdate,
      "route_id":sessionrouteid,
      "driver_id":sessiondriverID,
      "end_apartment_id":"0",
      "end_lat":lat,
      "end_lng":lang,
      "photo":attachmentlist[0],
      "remarks":"-",
      "journey_enddate":AppConstants.cdatetime,
      "journey_status":"1",
      "vehicle_id":sessionvehicleid,
      "wastage_weight":weightController.text,
      "wastage_measurement":selecttypeid.toString().isEmpty?"-":selecttypeid.toString(),
      "route_assign_id":sessionjournylogendid.toString(),
      //"measurement_type_id":selecttypeid

    };
    print(jsonEncode(body));

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
          showcomplete();
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
class Result{
  int id;
  String name;
  Result(this.id, this.name);
}