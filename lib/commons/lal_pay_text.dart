import 'package:flutter/material.dart';
import 'package:lal_pay/home/models/hex_color.dart';

class LalPay extends StatelessWidget{

  final String firstColor;
  final String secondColor;

  LalPay({this.firstColor,this.secondColor});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RichText(
      text: TextSpan(
          children: [
            TextSpan(text:'Lal',style: TextStyle(color: HexColor(firstColor),fontWeight: FontWeight.bold,fontSize: 25)),
            TextSpan(text: 'Pay',style: TextStyle(color: HexColor(secondColor),fontWeight: FontWeight.bold,fontSize: 25))
          ]
      ),
    );
  }
}