import 'dart:convert';
import 'package:http/http.dart' as http;
import 'appconstants/appconstants.dart';

Future<http.Response> GETToken() async {
  var url;

/*  String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
  print(basicAuth);*/

  url = Uri.parse(AppConstants.LIVE_URL + 'getLocation');
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  var response = await http.get(url, headers: headers);

  return response;
}
