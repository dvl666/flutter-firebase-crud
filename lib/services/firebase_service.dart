import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReferencePeople = db.collection('people');

  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  for (var element in queryPeople.docs) { 
    people.add(element.data());
  }

  await Future.delayed(const Duration(seconds: 5));

  return people;
}