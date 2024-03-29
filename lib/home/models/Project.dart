import 'package:cloud_firestore/cloud_firestore.dart';
class Project {
  final String id;
  final String title;
  final DocumentReference category;
  final DocumentReference team;
  Project.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['title'] != null),
        id = map['id'],
        category = map['category'],
        team = map['team'],
        title = map['title'];
  Project.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);

  @override
  String toString() => "Record<$title:$title>";
}