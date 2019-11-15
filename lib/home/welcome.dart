import 'package:flutter/material.dart';
import 'package:lal_pay/home/models/hex_color.dart';
import 'package:lal_pay/commons/lal_pay_text.dart';
import 'package:lal_pay/home/screen/PollScreen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
class Welcome extends StatefulWidget{

  _WelcomeState createState()=>_WelcomeState();
}

class _WelcomeState extends State<Welcome>{

  bool _validate = false;
  String _errorMessage = '';
  String _message='';
  bool _submitted = true;
  final controller = TextEditingController();
  @override
  void initState() {
     super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.all_inclusive,color: Colors.white,),
        title: LalPay(firstColor: 'ffffff',secondColor: 'EA001B',)
      ),
      backgroundColor: HexColor('F2F5FA'),
      body: DefaultTextStyle(
          style: TextStyle(fontSize: 20,color: Colors.black),
          child: Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Welcome to ',style: TextStyle(color: HexColor('23262B'),fontSize: 30.0,fontWeight: FontWeight.bold)),
                              ]
                          ),
                        ),
                        LalPay(firstColor: '2CB54B',secondColor: 'EA001B'),
                      ],
                    ),
                    SizedBox(height: 20,),
                    _form(context)
                  ],
                ),
              ),
            ),
          )
      )
    );
  }

  Widget _form(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
       TextField(
         controller: this.controller,
         decoration: InputDecoration(
           border: OutlineInputBorder(),
           hintText: 'Enter poll voting code',
           hintStyle: TextStyle(color: Colors.green[500]),
           errorText: _validate?_errorMessage:null,
           helperText: 'The code is a 4 digit number which is given by the manager to vote a project'
         ),
       ),
        Text(
          _message,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth:double.infinity ),
          child: RaisedButton(
              disabledColor: Colors.grey[500],
              disabledTextColor: Colors.grey,
              onPressed: _submitted?(){
                 if(controller.text.isEmpty){
                   _errorMessage="Please enter your voting code";
                 }else{
                   _handleClick();
                 }
              }:null,
              color: Colors.green[500],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Send',style: TextStyle(color: Colors.white),),
                  SizedBox(width: 10,),
                  _submitted?Text(''):Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            ),
        )
      ],
    );
  }

   _handleClick() async{
     setState(() {
       _submitted=false;
     });

     //unique code
      SharedPreferences preferences = await SharedPreferences.getInstance();

    String code = controller.text;
    Timer(Duration(seconds: 3),()=>(
        handleState(code)
    )
     );
   }
   handleState(String code){
     setState(() {
       _submitted=true;
     });
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => PollScreen(code)),
     );
   }

}