import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lal_pay/home/models/Project.dart';
import 'package:lal_pay/home/models/Team.dart';
class TeamWidget extends StatelessWidget{

  String id;
  TeamWidget(this.id);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildBod(context);
  }

  Widget _buildBod(BuildContext context){

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('teams').where('id',isEqualTo: id).snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData)
          return CircularProgressIndicator();
        return  _buildList(context, snapshot.data.documents);

      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Text(snapshot[0]['name']);
  }
}