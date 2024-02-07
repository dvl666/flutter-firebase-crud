import 'package:firebase_crud/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deletePeople(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text('Desea eliminar el registro de ${snapshot.data?[index]['name']}?'),
                        actions: [
                          TextButton(onPressed: () {
                            return Navigator.pop(context, false);
                          }, 
                          child: const Text('Cancelar')),
                          TextButton(onPressed: () {
                            return Navigator.pop(context, true);
                          }, 
                          child: const Text('Si, estoy seguro', style: TextStyle(color: Colors.red),))
                        ],
                      );
                    });
                    return result;
                  },
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['name']),
                    onTap: () async {
                      await Navigator.pushNamed(context, "/update", 
                        arguments: {
                          'uid': snapshot.data?[index]['uid'],
                          "name": snapshot.data?[index]['name']
                        });
                      setState(() {});
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}