import 'package:flutter/material.dart';
import 'package:lal_pay/home/models/Project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class VoteWidget extends StatelessWidget{

  Project project;

  VoteWidget(this.project);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildBod(context);
  }

  Widget _buildBod(BuildContext context){
    DocumentReference reference = Firestore.instance.collection('projects').document(project.id);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('votes').where('projects',isEqualTo: reference).snapshots(),
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
    return Text(snapshot.length.toString());
  }
}