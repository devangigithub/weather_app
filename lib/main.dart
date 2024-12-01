import 'package:api/provider/weather_provider.dart';
import 'package:api/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api/screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "home_page": (context) => HomeScreen(),
          "/": (context) => SplashScreen(),
        },
      ),
    ),
  );
}
