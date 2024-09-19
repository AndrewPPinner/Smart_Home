import 'package:flutter/material.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Configuration"),
        ),
        body: GridView.count(crossAxisCount: 3, childAspectRatio: 3/2, children: [
          ElevatedButton(
            onPressed: () async {
              //Add logic for EDITTING JSON service object in local storage
            },
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.blue),
            child: const Text("Edit Service")),

          ElevatedButton(
              onPressed: () async {
                //Add logic for saving JSON service object to local storage
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.blue),
              child: const Text("Add Service"))
        ]));
  }
}
