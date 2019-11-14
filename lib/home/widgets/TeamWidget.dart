import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lal_pay/home/models/Project.dart';
class TeamWidget extends StatelessWidget{

  Project project;
  TeamWidget(this.project);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('Gabrella');
  }
}