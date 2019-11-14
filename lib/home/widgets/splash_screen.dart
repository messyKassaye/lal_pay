import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'dart:async';
import 'package:lal_pay/home/welcome.dart';
class SplashScreen extends StatefulWidget{
  
  _SplashScreenState  createState()=> new _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Welcome())));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.green[500],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Loading(
                indicator: BallPulseIndicator(),
                size: 100.0
            ),
            Text(
              'VoteMe',
              style: TextStyle(
                  decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        )
      ),
    );
  }
}