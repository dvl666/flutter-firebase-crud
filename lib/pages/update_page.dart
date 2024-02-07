import 'package:firebase_crud/services/firebase_service.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  TextEditingController nameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar persona'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el nuevo nombre'
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updatePeople(arguments['uid'] ,nameController.text).then((_) {
                  Navigator.pop(context);
                });
              }, 
              child: const Text('Actualizar'))
          ],
        ),
      ),
    );
  }
}