import 'package:cloud_firestore/cloud_firestore.dart';
class Team {
  final String id;
  final String name;
  final String picture;
  Team.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['name'] != null),
        id = map['id'],
        picture = map['picture'],
        name = map['name'];
  Team.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);

  @override
  String toString() => "Record<$name:$name>";
}