import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  TextEditingController nameController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Name"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 232, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Ingresa el nuevo nombre",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await addPeople(nameController.text).then((_) {
                  Navigator.pop(context);
                  });
                
              },
              child: const Text("guardar"),
            ),
          ],
        ),
      ),
    );
  }
}