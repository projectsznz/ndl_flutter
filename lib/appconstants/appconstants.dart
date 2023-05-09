import 'package:intl/intl.dart';

class AppConstants{
  static const String LIVE_URL="http://assistlysolutions.com/ndl/";
  static const String LOGINDESC = "Enter your mobile number and password to login\nto your account";
  static String cdate =  DateFormat("yyyy-MM-dd").format(DateTime.now());//"2023-04-05";
  static String cdatetime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
}