import 'package:cloud_firestore/cloud_firestore.dart';
class Poll {
  final String name;
  final String id;
  final int code;
  final int duration;
  final String status;

  Poll.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['code'] != null),
        assert(map['duration'] != null),
        assert(map['status'] != null),
        id = map['id'],
        name = map['name'],
        code = map['code'],
        duration = map['duration'],
        status = map['status'];

  Poll.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);

  @override
  String toString() => "Record<$name:$name>";
}