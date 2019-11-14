import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lal_pay/home/models/Poll.dart';
import 'package:lal_pay/home/models/Project.dart';
import 'package:lal_pay/home/widgets/Categories.dart';
import 'package:lal_pay/home/widgets/VoteWidget.dart';
import 'package:lal_pay/home/widgets/TeamWidget.dart';
class PollsCard extends StatelessWidget{
   Poll poll;
   PollsCard(this.poll);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: _buildBod(context),
    );
  }

  Widget _buildBod(BuildContext context){

    DocumentReference reference = Firestore.instance.collection('polls').document(poll.id);

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('projects').where('poll',isEqualTo: reference).snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData)
          return Text(reference.documentID);
        return  Container(
          child: Column(
            children: <Widget>[
              _buildList(context, snapshot.data.documents)
            ],
          ),
        );

      },
    );
  }

   Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
     return ListView(
       scrollDirection: Axis.vertical,
       shrinkWrap: true,
       children: snapshot.map((data) => _buildListItem(context,data)).toList(),
     );
   }

   Widget _buildListItem(BuildContext context,DocumentSnapshot data){
     final project = Project.fromSnapshot(data);
     return Padding(
       padding: EdgeInsets.all(10),
       child: Container(
         decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(color: Colors.green[500]),
             borderRadius: BorderRadius.circular(5),
             boxShadow: [
               BoxShadow(
                   color: Colors.grey[700],
                   offset: Offset(1, 1,),
                   blurRadius: 5,
                   spreadRadius: 2
               )
             ]
         ),
         child: Column(
           children: <Widget>[
             Container(
               child: ListTile(
                 contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                 leading: CircleAvatar(backgroundColor: Colors.white,child: Text(capitalize(project.title)[0]),),
                 title: Text(capitalize(project.title),style: TextStyle(color: Colors.white,fontSize: 20),),
                 subtitle: Categories(project.category.documentID),
               ),
               decoration: BoxDecoration(
                   color: Colors.green
               ),
             ),
             Container(
                 child: Padding(
                   padding: EdgeInsets.all(10),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           Text('Total vote: '),
                           VoteWidget(project)
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           Text('Team name:'),
                           TeamWidget(project)
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: <Widget>[
                           RaisedButton(
                             color: Colors.green,
                             child: Text('Vote',style: TextStyle(color: Colors.white),),
                             onPressed: (){},
                           )
                         ],
                       )
                     ],
                   ),
                 )
             )
           ],
         ),
       ),
     );
   }

   String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}