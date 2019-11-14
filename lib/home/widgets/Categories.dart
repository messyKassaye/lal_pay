import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lal_pay/home/models/Category.dart';
class Categories extends StatelessWidget{

  String id;

  Categories(this.id);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: _buildBod(context),
    );
  }

  Widget _buildBod(BuildContext context){

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('categories').where('id',isEqualTo: id).snapshots(),
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
    final category = Category.fromSnapshot(data);
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(category.name,style: TextStyle(color: Colors.white),)
    );
  }
}