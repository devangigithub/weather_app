import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacementNamed('home_page');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Image.network("https://cdn-icons-png.freepik.com/256/12165/12165142.png?semt=ais_hybrid")
            ),
            SizedBox(height: 40,),
            Text("Weather App",style: TextStyle(color: Color(0xFF32B8DE),fontSize: 40),)
          ],
        ),
      ),
    );
  }
}