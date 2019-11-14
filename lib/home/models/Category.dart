import 'package:cloud_firestore/cloud_firestore.dart';
class Category {
  final String name;
  final String id;

  Category.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['id'] != null),
        id = map['id'],
        name = map['name'];

  Category.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);

  @override
  String toString() => "Record<$name:$name>";
}