import 'package:flutter/material.dart';
import 'package:lal_pay/commons/lal_pay_text.dart';
import 'package:lal_pay/home/widgets/PollsCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lal_pay/home/models/Poll.dart';
import 'package:lal_pay/home/welcome.dart';
class PollScreen extends StatelessWidget{
  String votingCode;
  PollScreen(this.votingCode);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.all_inclusive,color: Colors.white,),
          title: LalPay(firstColor: 'ffffff',secondColor: 'EA001B',)
      ),
      body: DefaultTextStyle(
          style: TextStyle(fontSize: 17,color: Colors.black),
          child: _buildBody(context)
      )
    );
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('polls').where('code',isEqualTo: int.parse(votingCode)).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container(
            child: Padding(
                padding: EdgeInsets.all(20),
              child: LinearProgressIndicator(),
            ),
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
     if(snapshot.length<=0){
       return Container(
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('There is not registered poll by this code number',
                 style: TextStyle(color: Colors.red,fontSize: 20),
               ),
               SizedBox(height: 15,),
               FlatButton.icon(
                   onPressed: (){
                     Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(builder: (context) => Welcome()),
                     );
                   },
                   icon: Icon(Icons.backspace,color: Colors.white,),
                   label: Text('Back to main',style: TextStyle(color: Colors.white),),
                   color: Colors.green[500],
               ),
             ],
           )
         ),
       );
     }else{
       return ListView(
         padding: const EdgeInsets.only(top: 10.0),
         children: snapshot.map((data) => _buildListItem(context, data)).toList(),
       );
     }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final polls = Poll.fromSnapshot(data);

    return Padding(
      key: ValueKey(polls.name),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text('List of available project for poll '+polls.name)
            ),
            showProjects(polls)
          ],
        )
      ),
    );
  }
Widget  showProjects(Poll poll){

    return PollsCard(poll);
}
}