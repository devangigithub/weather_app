// import 'dart:convert';
// import 'package:http/http.dart' as http;
// class ApiHelper{
//     static ApiHelper obj = ApiHelper._();
//     ApiHelper._() {}
//   Future<Map<String,dynamic>> getweather(String text)async{
//
//     http.Response weatherResponse= await http.get(Uri.parse('http://api.weatherapi.com/v1/current.json?key=88b9031bcf784c6eb1964934242811&q=22.3039,70.8022'));
//     interceptor(weatherResponse);
//     Map<String,dynamic> map = jsonDecode(weatherResponse.body);
//     return map;
//   }
//
//   void interceptor(http.Response response) {
//     print("user===> ${response.statusCode}");
//     print("user===> ${response.body}");
//   }
// }
