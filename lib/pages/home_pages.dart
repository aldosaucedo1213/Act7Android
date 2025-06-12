import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Suggested code may be subject to a license. Learn more: ~LicenseLog:2234836438.
        title: Text("Crud Aldo Saucedo"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 198, 68, 17),
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deletePeople(snapshot.data?[index]["uid"]);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "¿Estas seguro de querer eliminar a ${snapshot.data?[index]["name"]}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Si, estoy seguro"),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,

                  key: Key(snapshot.data?[index]["uid"]),
                  child: ListTile(
                    title: Text(snapshot.data?[index]["name"]),
                    onTap: (() async {
                      await Navigator.pushNamed(
                        context,
                        "/edit",
                        arguments: {
                          "name": snapshot.data?[index]["name"],
                          "uid": snapshot.data?[index]["uid"],
                        },
                      );
                      setState(() {});
                    })
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/add");
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}