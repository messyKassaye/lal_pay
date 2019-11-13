import 'package:flutter/material.dart';
import 'package:lal_pay/commons/commons.dart';
import 'package:lal_pay/home/models/hex_color.dart';
import 'package:lal_pay/commons/read_more_text.dart';
class CrediCard extends StatelessWidget{

 final String color;
 final String title;
 final String description;
 final String valid;

 CrediCard({this.color,this.title,this.description,this.valid});

 @override
 Widget build(BuildContext context) {
  // TODO: implement build
  double c_width = MediaQuery.of(context).size.width*0.8;
  return new Padding(
   padding: EdgeInsets.fromLTRB(8, 8, 20, 8),
   child: Container(
    height: 180,
    width: 300,
    decoration: BoxDecoration(
        color: HexColor(color),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
         BoxShadow(
             color: grey[600],
             offset: Offset(3, 1),
             blurRadius: 7,
             spreadRadius: 2
         )
        ]
    ),
    child: Column(
     children: <Widget>[
      Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
        Padding(
         padding: EdgeInsets.all(10.0),
         child: RichText(
             text: TextSpan(text: this.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))
         ),
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert,color: Colors.white)
        )
       ],
      ),
      Row(
       children: <Widget>[
         Container(
           width:c_width,
           padding: EdgeInsets.only(left:8.0,right: 8.0),

           child:Text(
             "$description",
             maxLines: 6,
             style: TextStyle(
              fontSize: 14,
              color: Colors.white
             ),
            textAlign: TextAlign.justify,
           )
         )
       ],
      ),
      Row(
       mainAxisAlignment: MainAxisAlignment.end,
       children: <Widget>[
        Padding(
         padding: EdgeInsets.only(right:8.0),
         child: Row(
           children: <Widget>[
            IconButton(
                icon: Icon(Icons.chevron_right,color: Colors.white),
                onPressed: ()=>{

                }
            )

           ],
         )
        )
       ],
      )
     ],
    ),
   ),
  );
 }
}