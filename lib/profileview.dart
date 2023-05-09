import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwaste/appcolors.dart';
import 'package:unwaste/login/login_page.dart';
import 'package:unwaste/splashscreen.dart';

class Profileview extends StatefulWidget {
  const Profileview({Key? key}) : super(key: key);

  @override
  State<Profileview> createState() => _ProfileviewState();
}


class _ProfileviewState extends State<Profileview> {
  String sessionmobile="";
  String sessiontoken="";
  String sessionname="";
  String sessionid="";
  String sessionrouteid="";
  String sessionroutename="";

@override
  void initState() {
    // TODO: implement initState
  getStringValuesSF();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text('Profile',style: TextStyle(color: Colors.black87,fontSize: 16),),
        actions: [
          InkWell(child: Icon(Icons.clear,color: Colors.black87,),onTap: (){
            Navigator.pop(context);
          },)
        ],
      ),
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png',width: 100,height: 100,),
                  Image.asset('assets/images/avatarmale.png',width: 100,height: 100,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(sessionname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(sessionmobile),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius:BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text('Driver ID : ${sessionid}',style: TextStyle(fontSize: 12),),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius:BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text('Route : ${sessionroutename.toString()=="null"?"":sessionroutename.toString()}',style: TextStyle(fontSize: 12),),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color:  AppColors.logoutcolor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: (){
                    logoutfunction(context);
                   },
                child: Text("Sign Out", style: const TextStyle(color: Colors.white, fontSize: 20),),
              ),
            ),
          ),

        ],
      ),
    ));
  }
Future getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sessiontoken = prefs.getString('Token').toString();
  sessionmobile = prefs.getString('Phone').toString();
  sessionname = prefs.getString('Name').toString();
  sessionid = prefs.getString('DriverID').toString();
  sessionrouteid = prefs.getString('RouteId').toString();
  sessionroutename = prefs.getString('RouteName').toString();
  print(sessiontoken);
  setState(() {});
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
