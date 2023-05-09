
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unwaste/profileview.dart';
import 'package:unwaste/splashscreen.dart';
import 'package:unwaste/uploadclass.dart';
const fetchBackground = "fetchBackground";

 void main()  {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )
    );
    return MaterialApp(
      title: 'Un Waste Network',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  SplashScreen(),
    );
  }
}
