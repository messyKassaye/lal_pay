import 'package:cloud_firestore/cloud_firestore.dart';
class Votes {
  final DocumentReference poll;
  final DocumentReference projects;
  final DocumentReference voter;

  Votes.fromMap(Map<String, dynamic> map)
      : assert(map['projects'] != null),
        assert(map['voter'] != null),
        assert(map['poll'] != null),
        projects = map['projects'],
        poll = map['poll'],
        voter = map['voter'];

  Votes.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);

  @override
  String toString() => "Record<$poll:$projects>";
}