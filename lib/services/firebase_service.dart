import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReferencePeople = db.collection('people');

  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  for (var element in queryPeople.docs) { 
    final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    final person = {
      'uid': element.id,
      'name': data['name'],
    };

    people.add(person);
  }

  // await Future.delayed(const Duration(seconds: 5));

  return people;
}

Future<void> addPeople(String name) async {
  await db.collection('people').add({'name': name});
}

Future<void> updatePeople(String uId, String newName) async {
  await db.collection('people').doc(uId).set({ 'name': newName });
}