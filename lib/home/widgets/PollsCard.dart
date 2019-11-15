import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lal_pay/home/models/Poll.dart';
import 'package:lal_pay/home/models/Project.dart';
import 'package:lal_pay/home/widgets/Categories.dart';
import 'package:lal_pay/home/widgets/VoteWidget.dart';
import 'package:lal_pay/home/widgets/TeamWidget.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
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
          return CircularProgressIndicator();
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
                       SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           Text('Team name:'),
                           TeamWidget(project.team.documentID),
                         ],
                       ),
                       SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           RaisedButton(
                             color: Colors.deepOrange[500],
                             onPressed: (){},
                             child: Text('Show team members',style: TextStyle(color: Colors.white),),
                           ),
                           Container(
                             width: 125,
                             child: ConstrainedBox(
                                 constraints: BoxConstraints(minWidth: double.infinity),
                               child: RaisedButton(
                                   onPressed: (){},
                                   color: Colors.green[500],
                                   child: Text('Vote',style: TextStyle(color: Colors.white),),
                               )
                             ),
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

   handleVote(project) async{

     String uniqueCode='';
     String id='';
     SharedPreferences preferences = await SharedPreferences.getInstance();
     if(preferences.get("uniqueId")==null){
       preferences.setString("uniqueId", generateCode().toString());
       preferences.setString('id', randomString(20));
       saveUniqueId(project,generateCode().toString(),randomString(20));
     }else{
       uniqueCode =await preferences.get("uniqueId");
       id = await preferences.get('id');
       saveUniqueId(project,uniqueCode, id);
     }

   }

   saveUniqueId(Project project,String code,String id){
     DocumentReference reference =Firestore.instance.collection('voters').document(id);
     if(reference.documentID!=null){
       startVoting(project, id);
     }else{
       Firestore.instance.collection('voters').add({
         "id":id,
         "uniqueId":code
       }).then(((document)=>startVoting(project,id)));
     }
   }


   startVoting(Project project,String id){
     DocumentReference pollReference = Firestore.instance.collection('polls').document(poll.id);
     DocumentReference projectReference = Firestore.instance.collection('projects').document(project.id);
     DocumentReference voteRegerence = Firestore.instance.collection('voters').document(id);
     Firestore.instance.collection('votes').add({
       'poll':pollReference,
       'projects':projectReference,
       'voter':voteRegerence
     });
   }
   generateCode(){
     var rng = new Random();
     var list = new List.generate(12, (_) => rng.nextInt(100));
     var concatenate = StringBuffer();

     list.forEach((item){
       concatenate.write(item);
     });
     return concatenate;
   }


   String randomString(int strlen) {
     const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
     Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
     String result = "";
     for (var i = 0; i < strlen; i++) {
       result += chars[rnd.nextInt(chars.length)];
     }
     return result;
   }

   String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}